module Quarterdeck
  class VisitsController < ApplicationController
    def index
      scope = visits_in_period.order(started_at: :desc)

      if params[:search].present?
        scope = scope.where(
          "landing_page LIKE :q OR referring_domain LIKE :q OR ip LIKE :q",
          q: "%#{params[:search]}%"
        )
      end

      scope = scope.where(browser: params[:browser]) if params[:browser].present?
      scope = scope.where(device_type: params[:device_type]) if params[:device_type].present?
      scope = scope.where(os: params[:os]) if params[:os].present?
      scope = scope.where(country: params[:country]) if params[:country].present?

      if params[:utm_only] == "1"
        scope = scope.where.not(utm_source: [ nil, "" ])
      end

      respond_to do |format|
        format.html do
          @pagy, @visits = pagy(:offset, scope, limit: 25)
          @browsers = visits_in_period.where.not(browser: [ nil, "" ]).distinct.pluck(:browser).sort
          @devices = visits_in_period.where.not(device_type: [ nil, "" ]).distinct.pluck(:device_type).sort
          @operating_systems = visits_in_period.where.not(os: [ nil, "" ]).distinct.pluck(:os).sort
          @countries_list = visits_in_period.where.not(country: [ nil, "" ]).distinct.pluck(:country).sort
        end
        format.csv do
          visits = scope.limit(10_000)
          headers = ["Started At", "Landing Page", "Referrer", "Browser", "Device", "OS", "Country", "City", "IP", "UTM Source", "UTM Medium", "UTM Campaign"]
          rows = visits.map do |v|
            [v.started_at, v.landing_page, v.referring_domain, v.browser, v.device_type, v.os, v.country, v.city, v.ip, v.utm_source, v.utm_medium, v.utm_campaign]
          end
          send_csv("visits", headers, rows)
        end
      end
    end

    def show
      @visit = Ahoy::Visit.find(params[:id])
      @events = @visit.events.order(time: :desc)
    end
  end
end
