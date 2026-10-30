require "spec_helper"

# Guards the self-contained, no-build promise: the stylesheet the engine links
# must carry the CSS Zero design tokens and components it uses, and must not
# reference any remote URL.
RSpec.describe "vendored quarterdeck.css" do
  let(:css) { File.read(File.expand_path("../../app/assets/stylesheets/quarterdeck.css", __dir__)) }

  it "includes the CSS Zero design tokens" do
    expect(css).to include("--color-bg:")
    expect(css).to include("--color-surface:")
    expect(css).to include("--color-text:")
  end

  it "includes every component Quarterdeck renders with" do
    %w[.card .table .badge .btn .input .pagination .tabs .alert .separator .skeleton .list .flash].each do |selector|
      expect(css).to include(selector)
    end
  end

  it "references no remote URLs" do
    expect(css).not_to match(%r{https?://})
  end
end
