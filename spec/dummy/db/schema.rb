ActiveRecord::Schema.define do
  create_table :ahoy_visits, force: true do |t|
    t.string :visit_token
    t.string :visitor_token
    t.string :ip
    t.text :user_agent
    t.text :referrer
    t.string :referring_domain
    t.text :landing_page
    t.string :browser
    t.string :os
    t.string :device_type
    t.string :country
    t.string :region
    t.string :city
    t.string :utm_source
    t.string :utm_medium
    t.string :utm_campaign
    t.string :utm_term
    t.string :utm_content
    t.datetime :started_at
  end

  create_table :ahoy_events, force: true do |t|
    t.references :visit
    t.integer :user_id
    t.string :name
    t.json :properties
    t.datetime :time
  end
end
