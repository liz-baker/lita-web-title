require "lita-web-title"
require "lita/rspec"

# A compatibility mode is provided for older plugins upgrading from Lita 3. Since this plugin
# was generated with Lita 4, the compatibility mode should be left disabled.
Lita.version_3_compatibility_mode = false

# Mock out web requests so we don't require the internet.
# Plus we can send canned "bad" data to test with.
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = {
    preserve_exact_body_bytes: true,
    serialize_with: :json
  }
end
