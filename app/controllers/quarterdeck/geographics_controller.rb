module Quarterdeck
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

      respond_to do |format|
        format.html
        format.csv do
          rows = []
          rows << ["--- Countries ---", ""]
          @countries.each { |c, count| rows << [c, count] }
          rows << ["--- Regions ---", ""]
          @regions.each { |r, count| rows << [r, count] }
          rows << ["--- Cities ---", ""]
          @cities.each { |c, count| rows << [c, count] }
          send_csv("geographic", ["Location", "Visits"], rows)
        end
      end
    end
  end
end
