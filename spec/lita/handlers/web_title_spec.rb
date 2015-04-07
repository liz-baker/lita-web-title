require 'spec_helper'

describe Lita::Handlers::WebTitle, lita_handler: true do
  let(:robot) { Lita::Robot.new(registry) }
  subject(:handler) { described_class.new(robot) }

  describe 'routing' do
    it { is_expected.to route('I like http://github.com/').to(:parse_uri_request) }
  end

  describe 'messages' do
    it 'returns the title for a mentioned URL' do
      send_command('I search on http://google.com/ a lot.')
      expect(replies.last).to match(/Google/)
    end

    it 'returns the title for only the first mentioned URL' do
      send_command('I search on http://google.com/ and http://yahoo.com/ a lot.')
      expect(replies.last).to match(/Google/)
      expect(replies.last).to_not match(/yahoo/i)
    end
  end

  describe '.parse_uri' do
    it 'returns the title' do
      expect(handler.parse_uri('https://google.com/'))
        .to match(/Google/)
    end
  end
end
