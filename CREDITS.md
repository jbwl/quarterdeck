# Credits

## Original author

**leopolicastro** — created the original `quarterdeck` gem
(https://github.com/leopolicastro/quarterdeck), including the Ahoy data model,
the dashboard pages, the controllers and the initial test suite.

This gem, `quarterdeck-csszero`, is a maintained, CSS Zero-native continuation of
that work.

## This release

**BL** — renamed the gem to `quarterdeck-csszero`, made the engine fully
self-contained, replaced the Tailwind/Chart.js CDN front end with CSS Zero,
vendored Chart.js, and fixed the PostgreSQL grouping bug on the Events page.

## Third-party

- [CSS Zero](https://github.com/lazaronixon/css-zero) by lazaronixon (MIT) — the
  component styles vendored into `app/assets/stylesheets/quarterdeck.css`.
- [Chart.js](https://www.chartjs.org) (MIT) — vendored at
  `app/javascript/quarterdeck/vendor/chart.umd.min.js`.
- [ahoy_matey](https://github.com/ankane/ahoy) by ankane (MIT).
