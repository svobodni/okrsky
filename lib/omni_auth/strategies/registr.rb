# -*- encoding : utf-8 -*-

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Registr < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "registr"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {:site => configatron.registry.uri}

      option :client_id, configatron.registr_oauth2_client_id
      option :client_secret, configatron.registr_oauth2_client_secret

      option :authorize_options, [:scope]
      option :scope, 'private'

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['person']['id'] }

      info do
        {
          :name => raw_info['person']['name'],
          :email => raw_info['person']['email'],
          :access_token => access_token.token,
          :refresh_token => access_token.refresh_token
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/auth/me.json').parsed
      end
    end
  end
end
