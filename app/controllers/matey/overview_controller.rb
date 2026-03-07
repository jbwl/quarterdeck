module Matey
  class OverviewController < ApplicationController
    def show
      @total_visits = visits_in_period.count
      @unique_visitors = visits_in_period.distinct.count(:visitor_token)
      @total_events = events_in_period.count

      @daily_visits = visits_in_period
        .group_by_day(:started_at)
        .count

      @top_pages = events_in_period
        .where(name: "$view")
        .group("properties->>'url'")
        .order(Arel.sql("count(*) DESC"))
        .limit(10)
        .count

      @top_referrers = visits_in_period
        .where.not(referring_domain: [ nil, "" ])
        .group(:referring_domain)
        .order(Arel.sql("count(*) DESC"))
        .limit(10)
        .count

      @browsers = visits_in_period
        .where.not(browser: [ nil, "" ])
        .group(:browser)
        .order(Arel.sql("count(*) DESC"))
        .limit(10)
        .count

      @devices = visits_in_period
        .where.not(device_type: [ nil, "" ])
        .group(:device_type)
        .order(Arel.sql("count(*) DESC"))
        .limit(10)
        .count

      @os = visits_in_period
        .where.not(os: [ nil, "" ])
        .group(:os)
        .order(Arel.sql("count(*) DESC"))
        .limit(10)
        .count

      @countries = visits_in_period
        .where.not(country: [ nil, "" ])
        .group(:country)
        .order(Arel.sql("count(*) DESC"))
        .limit(10)
        .count

      @top_events = events_in_period
        .where.not(name: "$view")
        .group(:name)
        .order(Arel.sql("count(*) DESC"))
        .limit(10)
        .count

      @campaigns = visits_in_period
        .where.not(utm_source: [ nil, "" ])
        .group(:utm_source)
        .order(Arel.sql("count(*) DESC"))
        .limit(10)
        .count
    end
  end
end
