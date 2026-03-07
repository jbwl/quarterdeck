module Quarterdeck
  class LiveController < ApplicationController
    def show
      @active_visitors = Ahoy::Visit.where(started_at: 5.minutes.ago..Time.current).distinct.count(:visitor_token)
      @current_pages = Ahoy::Event
        .where(name: "$view", time: 5.minutes.ago..Time.current)
        .group("properties->>'url'")
        .order(Arel.sql("count(*) DESC"))
        .limit(10)
        .count
      @recent_events = Ahoy::Event.order(time: :desc).limit(20).includes(:visit)

      respond_to do |format|
        format.html
        format.json do
          render json: {
            active_visitors: @active_visitors,
            current_pages: @current_pages.map { |url, count| { url: url, count: count } },
            recent_events: @recent_events.map { |e|
              {
                time: e.time.strftime("%H:%M:%S"),
                name: e.name,
                properties: e.properties,
                visitor: e.visit&.visitor_token&.first(8)
              }
            }
          }
        end
      end
    end
  end
end
