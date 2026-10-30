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
  end
end
