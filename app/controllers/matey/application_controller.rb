module Matey
  class ApplicationController < ActionController::Base
    include Pagy::Backend

    before_action :authenticate_matey!

    helper Pagy::Frontend
    helper_method :period, :period_range

    private

    def authenticate_matey!
      if Matey.authentication_block
        instance_exec(&Matey.authentication_block)
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
      else
        30.days.ago.beginning_of_day..Time.current
      end
    end

    def visits_in_period
      @visits_in_period ||= Ahoy::Visit.where(started_at: period_range)
    end

    def events_in_period
      @events_in_period ||= Ahoy::Event.where(time: period_range)
    end
  end
end
