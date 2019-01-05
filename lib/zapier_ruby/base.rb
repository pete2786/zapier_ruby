module ZapierRuby
  class Base
    attr_accessor :logger

    private

    def post_zap(params)
      rest_client.post(params, zap_headers)
    rescue RestClient::ExceptionWithResponse => err
      raise ZapierServerError, err
    end

    def rest_client
      @rest_client ||= RestClient::Resource.new(zap_url, ssl_version: 'TLSv1')
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
