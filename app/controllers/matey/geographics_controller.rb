module Matey
  class GeographicsController < ApplicationController
    def show
      geo_visits = visits_in_period

      @countries = geo_visits
        .where.not(country: [ nil, "" ])
        .group(:country)
        .order(Arel.sql("count(*) DESC"))
        .count

      @regions = geo_visits
        .where.not(region: [ nil, "" ])
        .group(:region)
        .order(Arel.sql("count(*) DESC"))
        .limit(25)
        .count

      @cities = geo_visits
        .where.not(city: [ nil, "" ])
        .group(:city)
        .order(Arel.sql("count(*) DESC"))
        .limit(25)
        .count
    end
  end
end
