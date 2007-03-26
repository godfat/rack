require 'rack/auth/abstract/request'
require 'rack/auth/digest/params'
require 'rack/auth/digest/nonce'

module Rack
  module Auth
    module Digest
      class Request < Auth::AbstractRequest

        def method
          @env['REQUEST_METHOD']
        end

        def digest?
          :digest == scheme
        end

        def correct_uri?
          @env['PATH_INFO'] == uri
        end
                
        def nonce
          @nonce ||= Nonce.parse(params['nonce'])
        end

        def params
          @params ||= Params.parse(parts.last)
        end

        def method_missing(sym)
          if params.has_key? key = sym.to_s
            return params[key]
          end
          super
        end

      end
    end
  end
end