# Changelog

## 1.1.0

Added a **Top Events** page (`/analytics/top_events`).

- Reports the top values of **any** property found on your events — e.g.
  `campaign_name` — so in-app campaigns (catalogs, banners, newsletters) can be
  ranked without the visit-level UTM columns the Campaigns page uses.
- Property keys are discovered from the events in the selected period; no
  configuration required. Works on PostgreSQL and SQLite (`jsonb_object_keys` /
  `json_each`).
- Filter by property and, optionally, by event name. Top 5 rendered as a
  horizontal bar chart; the full breakdown is paginated (25 per page) with a CSV
  export.
- **Back to app**: the header links back to the host application's root
  (`main_app.root_path`).

## 1.0.0

Renamed the gem to `quarterdeck-csszero` and made the engine fully self-contained.

- **Self-contained engine**: renders its own CSS Zero layout and ships its own
  assets. No dependency on the host app's layout, stylesheets or JavaScript.
- **CSS Zero UI** (>= 4.3.0), including charts. All Tailwind markup removed.
- **No CDNs**: Chart.js is vendored into the engine (`chart.umd.min.js`); Stimulus
  comes from `stimulus-rails`. The Tailwind Play CDN and the jsdelivr Chart.js pin
  are gone.
- **Fixed** a `PG::GroupingError` on the Events page by dropping the `ORDER BY`
  before `group_by_day` (`scope.reorder(nil).group_by_day(:time).count`).
- **Dependencies**: require `pagy >= 43` (the code uses `Pagy::Method`), declare
  `ahoy_matey`, add `css-zero`, `importmap-rails` and `stimulus-rails`.
- Removed the date-range Stimulus controller in favour of a plain GET form.
- Added `rake quarterdeck_css_zero:update_css_zero` to regenerate the vendored component
  styles on `css-zero` version bumps.

## 0.1.0

Initial release of the original `quarterdeck` gem by leopolicastro (Tailwind CDN +
Chart.js from jsdelivr).
