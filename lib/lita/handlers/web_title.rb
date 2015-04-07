require "uri"
require "nokogiri"
module Lita
  module Handlers
    class WebTitle < Handler
      URI_PROTOCOLS = %w( http https )
      route(URI.regexp(URI_PROTOCOLS), :parse_uri_request, help: {
        "URL" => "Responds with the title of the web page at URL"
      })

      def parse_uri_request(request)
        requestUri = URI::extract(request.message.body, URI_PROTOCOLS).first
        result = parse_uri(requestUri)
        request.reply(result.delete("\n").strip) unless result.nil?
      end

      def parse_uri(uriString)
        httpRequest = http.get(uriString)
        if httpRequest.status == 200 then
          return unless httpRequest.headers['Content-Type'] =~ %r{text/x?html}
          page = Nokogiri::HTML(httpRequest.body)
          page.css("title").first.text
        elsif [300, 301, 302, 303].include? httpRequest.status then
          parse_uri httpRequest.headers["Location"]
        else
          nil
        end
      rescue Exception => msg
        log.error("lita-web-title: Exception attempting to load URL: #{msg}")
        nil
      end
    end

    Lita.register_handler(WebTitle)
  end
end
