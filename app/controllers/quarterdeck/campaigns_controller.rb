module Quarterdeck
  class CampaignsController < ApplicationController
    def show
      campaign_visits = visits_in_period.where.not(utm_source: [ nil, "" ])

      @total_campaign_visits = campaign_visits.count

      @sources = campaign_visits
        .group(:utm_source)
        .order(Arel.sql("count(*) DESC"))
        .count

      @mediums = campaign_visits
        .where.not(utm_medium: [ nil, "" ])
        .group(:utm_medium)
        .order(Arel.sql("count(*) DESC"))
        .count

      @campaigns = campaign_visits
        .where.not(utm_campaign: [ nil, "" ])
        .group(:utm_campaign)
        .order(Arel.sql("count(*) DESC"))
        .count

      @terms = campaign_visits
        .where.not(utm_term: [ nil, "" ])
        .group(:utm_term)
        .order(Arel.sql("count(*) DESC"))
        .count

      @contents = campaign_visits
        .where.not(utm_content: [ nil, "" ])
        .group(:utm_content)
        .order(Arel.sql("count(*) DESC"))
        .count

      respond_to do |format|
        format.html
        format.csv do
          rows = []
          rows << ["--- Sources ---", ""]
          @sources.each { |s, c| rows << [s, c] }
          rows << ["--- Mediums ---", ""]
          @mediums.each { |m, c| rows << [m, c] }
          rows << ["--- Campaigns ---", ""]
          @campaigns.each { |camp, c| rows << [camp, c] }
          send_csv("campaigns", ["Item", "Visits"], rows)
        end
      end
    end
  end
end
