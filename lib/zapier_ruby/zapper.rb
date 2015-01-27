module ZapierRuby
  class Zapper
    attr_accessor :zap_name, :logger
    delegate :logger, to: :config

    def initialize(zap_name)
      self.zap_name = zap_name
    end

    def zap(params)
      if zap_web_hook_id
        logger.error "No zap configured for #{zap_name}. Check config/zapier_ruby.yml"
        return false
      end

      logger.info "Zapping #{zap_name} with params: #{params.to_json}"
      post_zap(params)
    end

    def post_zap(params)
      begin
        rest_client.post(params, zap_headers)
        true
      rescue Exception => e
        logger.error "Unable to post to Zapier url: #{zap_url} with params: #{params.to_json}. Error: #{e.message}"
        false
      end
    end
    private :post_zap

    def rest_client
      @rest_client ||= RestClient::Resource.new(zap_url, ssl_version: 'TLSv1')
    end
    private :rest_client

    def zap_web_hook_id
      return @zap_web_hook if defined?(@zap_web_hook)

      @zap_web_hook = config.web_hooks[zap_name]
    end
    private :zap_web_hook_id

    def zap_headers
      {
        "Accept" => " application/json",
        "Content-Type" => "application/json"
      }
    end
    private :zap_headers

    def zap_url
      "#{config.base_url}#{zap_web_hook_id}/"
    end
    private :zap_url

    def config
      @config ||= Zapier::Config.new
    end
    private :config
  end
end