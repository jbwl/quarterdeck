source "https://rubygems.org"

# Specify your gem's dependencies in quarterdeck.gemspec.
gemspec

gem "puma"
gem "sqlite3"
gem "propshaft"

group :development, :test do
  gem "rspec-rails"
end

# PostgreSQL is only needed to run the events grouping regression against a
# real PostgreSQL (see .github/workflows/ci.yml). Opt in locally with:
#   bundle config set --local with postgres && bundle install
group :postgres do
  gem "pg"
end
