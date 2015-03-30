require "uri"
require "nokogiri"
module Lita
  module Handlers
    class WebTitle < Handler
      route(URI.regexp(["http", "https"]), :parse_uri_request, help: {
        "URL" => "Responds with the title of the web page at URL"
      })

      def parse_uri_request(request)
        requestUri = URI::extract(request.message.body, ["http", "https"])
        result = parse_uri(requestUri[0])
        result.delete!("\n").strip!
        request.reply(result) unless result.nil?
      end

      def parse_uri(uriString)
        httpRequest = http.get(uriString)
        if httpRequest.status == 200 then
          page = Nokogiri::HTML(httpRequest.body)
          page.css("title")[0].text
        elsif [300, 301, 302, 303].include? httpRequest.status then
          parse_uri httpRequest.headers["Location"]
        else
          nil
        end
      rescue Exception => msg
        log.error("lita-web-title: Exception attempting to load URL: #{msg}")
      end
    end

    Lita.register_handler(WebTitle)
  end
end
