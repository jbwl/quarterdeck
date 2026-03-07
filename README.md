# Matey

A beautiful analytics dashboard engine for Rails apps already using [ahoy_matey](https://github.com/ankane/ahoy) for tracking. Matey reads your existing Ahoy data and presents it in a modern dashboard with charts, tables, and filters.

No database migrations needed — Matey reads directly from your `ahoy_visits` and `ahoy_events` tables.

## Features

- **Overview** — Total visits, unique visitors, events, daily chart, top pages, referrers, browsers, devices, OS, countries, campaigns
- **Visits** — Searchable/filterable visit log with pagination and detail views
- **Events** — Event breakdown with daily chart, filtering by event name
- **Campaigns** — UTM breakdowns (source, medium, campaign, term, content) with charts
- **Geographic** — Country, region, and city breakdowns with charts

Built with Tailwind CSS, Chart.js, and Stimulus.

## Requirements

- Rails 8.1+
- [ahoy_matey](https://github.com/ankane/ahoy) 4+ (already installed and configured in your app)

## Installation

Add to your Gemfile:

```ruby
gem "matey"
```

Run the install generator:

```bash
bundle install
rails generate matey:install
```

This will:
1. Create `config/initializers/matey.rb`
2. Mount the engine at `/analytics` in your routes

Or set up manually:

```ruby
# config/routes.rb
mount Matey::Engine => "/analytics"
```

## Configuration

```ruby
# config/initializers/matey.rb

# Require authentication
Matey.authenticate_with do
  redirect_to main_app.root_path unless current_user&.admin?
end
```

## Pages

| Path | Description |
|------|-------------|
| `/analytics` | Overview dashboard |
| `/analytics/visits` | Visit log with filters |
| `/analytics/visits/:id` | Visit detail with events |
| `/analytics/events` | Event breakdown |
| `/analytics/campaigns` | UTM campaign analysis |
| `/analytics/geographic` | Geographic breakdown |

All pages support period filtering: Today, 7 days, 30 days, 90 days.

## Development

```bash
bundle install
bundle exec rspec
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


[![Certified Shovelware](https://justin.searls.co/img/shovelware.svg)](https://justin.searls.co/shovelware/)

