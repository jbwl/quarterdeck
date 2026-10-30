require "fileutils"

namespace :quarterdeck_css_zero do
  desc "Regenerate app/assets/stylesheets/quarterdeck-csszero.css from the installed css-zero gem"
  task :update_css_zero do
    root = File.expand_path("../..", __dir__)
    gem_dir = Gem::Specification.find_by_name("css-zero").gem_dir
    templates = File.join(gem_dir, "lib/generators/css_zero/add/templates/app/assets/stylesheets")
    base_css  = File.join(gem_dir, "lib/generators/css_zero/install/templates/app/assets/stylesheets/base.css")
    version = Gem::Specification.find_by_name("css-zero").version

    # Components Quarterdeck renders with. Keep in sync with the views.
    components = %w[card table badge button input pagination tabs alert separator skeleton list flash]

    output = +""
    output << "/*\n"
    output << " * Quarterdeck CssZero stylesheet.\n"
    output << " *\n"
    output << " * The section below is vendored verbatim from the CSS Zero gem (v#{version})\n"
    output << " * so the engine is self-contained and never depends on styles the host app\n"
    output << " * may or may not have copied in via `css_zero:add`.\n"
    output << " *\n"
    output << " * Regenerate with: bundle exec rake quarterdeck_css_zero:update_css_zero\n"
    output << " * Do not edit the vendored section by hand; edit\n"
    output << " * app/assets/stylesheets/quarterdeck-csszero/dashboard.css instead.\n"
    output << " */\n\n"

    # The semantic design tokens (`--color-*`) and base element styles live in
    # the install template, not in the gem, so the engine vendors them too.
    if File.exist?(base_css)
      output << "/* ---- css-zero/base.css (install template) ---- */\n"
      output << File.read(base_css).strip << "\n\n"
    else
      warn "quarterdeck_css_zero: missing css-zero install base.css"
    end

    components.each do |component|
      path = File.join(templates, "#{component}.css")
      unless File.exist?(path)
        warn "quarterdeck_css_zero: missing component stylesheet #{component}.css in css-zero #{version}"
        next
      end

      body = File.read(path)
      # Image references are resolved relative to this stylesheet, so point
      # them at the images vendored into the engine.
      body = body.gsub('url("loading.svg")', 'url("quarterdeck-csszero/loading.svg")')
      body = body.gsub('url("chevron-down-zinc-500.svg")', 'url("quarterdeck-csszero/chevron-down-zinc-500.svg")')

      output << "/* ---- css-zero/#{component}.css ---- */\n"
      output << body.strip << "\n\n"
    end

    dashboard = File.join(root, "app/assets/stylesheets/quarterdeck-csszero/dashboard.css")
    if File.exist?(dashboard)
      output << "/* ---- quarterdeck-csszero/dashboard.css ---- */\n"
      output << File.read(dashboard).strip << "\n"
    end

    target = File.join(root, "app/assets/stylesheets/quarterdeck-csszero.css")
    FileUtils.mkdir_p(File.dirname(target))
    File.write(target, output)
    puts "Wrote #{target} (#{components.size} css-zero components, css-zero v#{version})"
  end
end
