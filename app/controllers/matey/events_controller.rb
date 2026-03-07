module Matey
  class EventsController < ApplicationController
    def index
      scope = events_in_period.order(time: :desc)

      if params[:name].present?
        scope = scope.where(name: params[:name])
      end

      @total_events = scope.count
      @unique_events = scope.distinct.count(:name)

      @daily_events = scope
        .group_by_day(:time)
        .count

      @event_names = events_in_period
        .group(:name)
        .order(Arel.sql("count(*) DESC"))
        .count

      @pagy, @events = pagy(:offset, scope, limit: 25)
    end
  end
end
