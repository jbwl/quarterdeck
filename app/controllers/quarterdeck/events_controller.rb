module Quarterdeck
  class EventsController < ApplicationController
    def index
      scope = events_in_period.order(time: :desc)

      if params[:name].present?
        scope = scope.where(name: params[:name])
      end

      @total_events = scope.count
      @unique_events = scope.distinct.count(:name)

      prev_scope = previous_events
      prev_scope = prev_scope.where(name: params[:name]) if params[:name].present?
      @prev_total_events = prev_scope.count
      @prev_unique_events = prev_scope.distinct.count(:name)

      @daily_events = scope
        .group_by_day(:time)
        .count

      @event_names = events_in_period
        .group(:name)
        .order(Arel.sql("count(*) DESC"))
        .count

      respond_to do |format|
        format.html do
          @pagy, @events = pagy(:offset, scope, limit: 25)
        end
        format.csv do
          rows = @event_names.map { |name, count| [name, count] }
          send_csv("events", ["Event Name", "Count"], rows)
        end
      end
    end
  end
end
