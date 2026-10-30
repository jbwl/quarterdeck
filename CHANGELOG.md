# Changelog

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
- Added `rake quarterdeck:update_css_zero` to regenerate the vendored component
  styles on `css-zero` version bumps.

## 0.1.0

Initial release of the original `quarterdeck` gem by leopolicastro (Tailwind CDN +
Chart.js from jsdelivr).
