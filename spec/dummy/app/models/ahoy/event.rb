module Ahoy
  class Event < ActiveRecord::Base
    self.table_name = "ahoy_events"
    belongs_to :visit, class_name: "Ahoy::Visit"
  end
end
