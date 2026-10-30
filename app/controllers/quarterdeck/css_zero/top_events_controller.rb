module Quarterdeck::CssZero
  class TopEventsController < ApplicationController
    PER_PAGE = 25
    CHART_LIMIT = 5

    def show
      scope = events_in_period
      scope = scope.where(name: params[:name]) if params[:name].present?

      @event_names = events_in_period.group(:name).order(Arel.sql("count(*) DESC")).count
      @property_keys = property_keys
      @property_key = selected_property_key
      @breakdown = @property_key ? breakdown(scope, @property_key) : {}

      respond_to do |format|
        format.html do
          @pagy, @rows = pagy(:offset, @breakdown.to_a, limit: PER_PAGE)
          @chart_rows = @breakdown.first(CHART_LIMIT)
        end
        format.csv do
          rows = @breakdown.map { |value, count| [ value, count ] }
          send_csv("top_events", [ @property_key || "Value", "Events" ], rows)
        end
      end
    end

    private

    # Property keys are read from the events themselves, so the filter reflects
    # whatever the host app actually tracks. Set-returning JSON functions differ
    # between PostgreSQL and SQLite, hence the branch.
    def property_keys
      @property_keys ||= begin
        keys =
          if postgres?
            Ahoy::Event
              .where(time: period_range)
              .where(Arel.sql("jsonb_typeof(#{properties_json}) = 'object'"))
              .distinct
              .pluck(Arel.sql("jsonb_object_keys(#{properties_json})"))
          else
            Ahoy::Event
              .from(Arel.sql("#{table}, json_each(#{table}.properties)"))
              .where(time: period_range)
              .where(Arel.sql("json_type(#{table}.properties) = 'object'"))
              .distinct
              .pluck(Arel.sql("json_each.key"))
          end

        keys.compact_blank.sort
      end
    end

    # Only a key discovered above is ever used, so an unknown or tampered
    # `property` param falls back to the first one.
    def selected_property_key
      requested = params[:property].presence
      return requested if requested && @property_keys.include?(requested)

      @property_keys.first
    end

    # Groups by the extracted value. `reorder(nil)` drops the ordering
    # PostgreSQL rejects when grouping, the same trap the Events page guards
    # against.
    def breakdown(scope, key)
      property = "properties->>#{quoted(key)}"

      scope
        .reorder(nil)
        .where("#{property} IS NOT NULL AND #{property} != ''")
        .group(property)
        .order(Arel.sql("count(*) DESC"))
        .count
    end

    def quoted(value)
      Ahoy::Event.connection_pool.with_connection { |connection| connection.quote(value) }
    end

    def table
      Ahoy::Event.quoted_table_name
    end

    # Mirrors Ahoy's own jsonb handling: only cast when the column is not jsonb.
    def properties_json
      cast = Ahoy::Event.columns_hash["properties"].type == :jsonb ? "" : "::jsonb"
      "properties#{cast}"
    end

    def postgres?
      Ahoy::Event.connection_db_config.adapter.to_s.match?(/postg/i)
    end
  end
end
