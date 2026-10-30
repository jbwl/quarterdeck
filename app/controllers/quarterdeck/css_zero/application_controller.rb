require "csv"

module Quarterdeck::CssZero
  class ApplicationController < ActionController::Base
    include Pagy::Method

    layout "quarterdeck/css_zero/application"

    before_action :authenticate_quarterdeck!

    helper_method :period, :period_range, :previous_period_range

    private

    def authenticate_quarterdeck!
      if Quarterdeck::CssZero.authentication_block
        instance_exec(&Quarterdeck::CssZero.authentication_block)
      end
    end

    def period
      @period ||= params[:period].presence || "30d"
    end

    def period_range
      @period_range ||= case period
      when "today"
        Time.current.beginning_of_day..Time.current
      when "7d"
        7.days.ago.beginning_of_day..Time.current
      when "30d"
        30.days.ago.beginning_of_day..Time.current
      when "90d"
        90.days.ago.beginning_of_day..Time.current
      when "custom"
        start_date = Date.parse(params[:start_date]).beginning_of_day
        end_date = Date.parse(params[:end_date]).end_of_day
        start_date..end_date
      else
        30.days.ago.beginning_of_day..Time.current
      end
    end

    def previous_period_range
      @previous_period_range ||= begin
        duration = period_range.last - period_range.first
        (period_range.first - duration)..period_range.first
      end
    end

    def visits_in_period
      @visits_in_period ||= Ahoy::Visit.where(started_at: period_range)
    end

    def events_in_period
      @events_in_period ||= Ahoy::Event.where(time: period_range)
    end

    def previous_visits
      Ahoy::Visit.where(started_at: previous_period_range)
    end

    def previous_events
      Ahoy::Event.where(time: previous_period_range)
    end

    def send_csv(filename, headers, rows)
      csv_data = CSV.generate(headers: true) do |csv|
        csv << headers
        rows.each { |row| csv << row }
      end
      send_data csv_data, filename: "#{filename}-#{Date.current}.csv", type: "text/csv"
    end
  end
end
