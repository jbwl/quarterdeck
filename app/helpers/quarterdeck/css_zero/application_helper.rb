module Quarterdeck::CssZero
  module ApplicationHelper
    # Renders a CSS Zero chart canvas wired to the engine's chart Stimulus
    # controller. `data` and `options` are Ruby hashes serialized to JSON.
    #
    #   <%= quarterdeck_chart type: "line", data: { labels: [...], datasets: [...] } %>
    def quarterdeck_chart(type:, data:, options: {}, **html_options)
      tag.canvas(
        data: {
          controller: "chart",
          chart_type_value: type,
          chart_data_value: data.to_json,
          chart_options_value: options.to_json
        },
        **html_options
      )
    end

    # The dashboard's sections, shared by the desktop header menu and the
    # mobile sheet menu. Marks the current section active.
    def quarterdeck_sections
      [
        { name: "Overview",   path: quarterdeck_css_zero.root_path,       controller: "overview" },
        { name: "Visits",     path: quarterdeck_css_zero.visits_path,     controller: "visits" },
        { name: "Events",     path: quarterdeck_css_zero.events_path,     controller: "events" },
        { name: "Top Events", path: quarterdeck_css_zero.top_events_path, controller: "top_events" },
        { name: "Campaigns",  path: quarterdeck_css_zero.campaigns_path,  controller: "campaigns" },
        { name: "Geographic", path: quarterdeck_css_zero.geographic_path, controller: "geographics" },
        { name: "Live",       path: quarterdeck_css_zero.live_path,       controller: "live" }
      ].map { |section| section.merge(active: controller_name == section[:controller]) }
    end
  end
end
