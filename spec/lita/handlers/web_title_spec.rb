require 'spec_helper'

describe Lita::Handlers::WebTitle, lita_handler: true do
  before :each do
    registry.config.handlers.web_title.tap do |config|
      config.ignore_patterns = ["example.com","github.com"]
    end
  end

  let(:robot) { Lita::Robot.new(registry) }
  subject(:handler) { described_class.new(robot) }

  describe 'routing' do
    it { is_expected.to route('I like http://github.com/').to(:parse_uri_request) }
  end

  describe 'messages', :vcr do
    it 'returns the title for a mentioned URL' do
      send_command('I search on http://google.com/ a lot.')
      expect(replies.last).to match(/Google/)
    end

    it 'returns the title for only the first mentioned URL' do
      send_command('I search on http://google.com/ and http://yahoo.com/ a lot.')
      expect(replies.last).to match(/Google/)
      expect(replies.last).to_not match(/yahoo/i)
    end

    it 'returns nothing for URLs that are not HTML' do
      send_command('This is the logo https://www.google.com/images/srpr/logo11w.png')
      expect(replies.last).to be_nil
    end

    it 'ignores example.com links' do
      send_command('I hate http://www.example.com/')
      expect(replies.last).to be_nil
    end
   end

  describe '.parse_uri', :vcr do
    it 'returns the title' do
      expect(handler.parse_uri('https://google.com/'))
        .to match(/Google/)
    end
  end
end
