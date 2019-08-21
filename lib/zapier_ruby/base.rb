module ZapierRuby
  class Base
    attr_accessor :logger

    private

    def post_zap(params)
      uri = URI.parse(zap_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, zap_headers)
      request.body = params.to_json
      response = http.request(request)

      # return if successful
      response.code == 200
    rescue StandardError => err
      raise ZapierServerError, err
    end

    def zap_web_hook_id
      @zap_web_hook ||= config.web_hooks[zap_name]
    end

    def zap_headers
      {
        "Accept" => " application/json",
        "Content-Type" => "application/json"
      }
    end

    def zap_url
      "#{config.base_uri}#{zap_web_hook_id}/"
    end

    def config
      ZapierRuby.config
    end
  end
end
