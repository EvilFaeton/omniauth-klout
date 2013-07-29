require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Klout < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://api.klout.com',
        :authorize_url => 'https://api.klout.com/v2/oauth/',
        :token_url => 'https://api.klout.com/v2/oauth/token.json'
      }

      def request_phase
        redirect request_url
      end

      uid { request.params['user'] }
      info do
        {
          authCode: request.params['authCode'],
        }
      end

      private

      def request_url
        "#{options["client_options"]["authorize_url"]}?apiKey=#{options["client_id"]}&redirect=#{callback_url}"
      end

    end
  end
end


OmniAuth.config.add_camelization 'klout', 'Klout'
