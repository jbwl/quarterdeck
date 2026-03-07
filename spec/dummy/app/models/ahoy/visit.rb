module Ahoy
  class Visit < ActiveRecord::Base
    self.table_name = "ahoy_visits"
    has_many :events, class_name: "Ahoy::Event"
  end
end
