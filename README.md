# Quarterdeck

A self-contained, no-build analytics dashboard engine for Rails 8.1+ apps already
using [ahoy_matey](https://github.com/ankane/ahoy) for tracking. Quarterdeck reads
your existing Ahoy data and presents it in a dashboard styled entirely with
[CSS Zero](https://github.com/lazaronixon/css-zero) (>= 4.3.0).

- **No database migrations** — Quarterdeck reads directly from your `ahoy_visits`
  and `ahoy_events` tables.
- **Fully self-contained** — the engine renders its own CSS Zero layout and ships
  its own assets. It does not depend on your app's layout, stylesheets or
  JavaScript, and you do not need to add anything to `app/views/layouts`.
- **No build step** — no Node, no Tailwind CLI, no esbuild. Styling is CSS Zero;
  JavaScript is loaded with importmap-rails.
- **No CDNs at runtime** — Chart.js is vendored inside the engine and Stimulus is
  served from the `stimulus-rails` gem. The dashboard works offline and under a
  strict Content Security Policy.

The only requirement from the host application is that it uses **ahoy_matey** to
collect stats.

## Requirements

- **Rails 8.1+**
- **[ahoy_matey](https://github.com/ankane/ahoy) 4+** — already installed and
  tracking visits/events in your `ahoy_visits` / `ahoy_events` tables

`css-zero`, `importmap-rails`, `stimulus-rails`, `pagy`, `groupdate` and `csv` are
pulled in as gem dependencies — you do not add them yourself.

## Installation

Add to your Gemfile:

```ruby
gem "quarterdeck-csszero"
```

Run the install generator:

```bash
bundle install
rails generate quarterdeck:install
```

This will:

1. Create `config/initializers/quarterdeck.rb`
2. Mount the engine at `/analytics` in your routes

Or set up manually:

```ruby
# config/routes.rb
mount Quarterdeck::Engine => "/analytics"
```

That's it — no layout, stylesheet or JavaScript changes are required.

## Configuration

```ruby
# config/initializers/quarterdeck.rb

# Require authentication (optional)
Quarterdeck.authenticate_with do
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
| `/analytics/live` | Real-time active visitors |

All pages support period filtering: Today, 7 days, 30 days, 90 days, or a custom
date range.

## Charts and CSS

- UI components (`.card`, `.table`, `.badge`, `.btn`, `.input`, `.tabs`,
  `.pagination`, `.alert`, `.separator`, …) come from CSS Zero. The engine ships a
  single `quarterdeck.css` that vendors the CSS Zero components it uses, plus a
  small dashboard layout built on CSS Zero variables, so it looks native whatever
  theme your app has active.
- Charts are rendered by a chart Stimulus controller that mirrors CSS Zero's chart
  component, drawing with the Chart.js copy vendored inside the engine.

### Updating the vendored CSS Zero components

When you bump the `css-zero` dependency, regenerate the vendored styles:

```bash
bundle exec rake quarterdeck:update_css_zero
```

Do not edit `app/assets/stylesheets/quarterdeck.css` by hand; edit
`app/assets/stylesheets/quarterdeck/dashboard.css` and regenerate.

## Development

```bash
bundle install
bundle exec rspec
```

To run the events grouping regression against PostgreSQL (which is where the
`GROUP BY ... ORDER BY` bug shows up):

```bash
bundle config set --local with postgres
bundle install
DATABASE_URL=postgres://localhost/quarterdeck_test bundle exec rspec
```

## Credits

Quarterdeck is a maintained, CSS Zero-native continuation of the original
[`quarterdeck`](https://github.com/leopolicastro/quarterdeck) gem by
**leopolicastro**, which is credited here and in `CREDITS.md`. The original data
model, dashboard pages and Ahoy integration are theirs; this release renames the
gem and replaces the Tailwind/Chart.js CDN front end with a self-contained CSS
Zero one.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
