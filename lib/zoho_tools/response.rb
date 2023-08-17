# frozen_string_literal: true

module ZohoTools
  class Response
    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def success?
      response.code == 200 && (!body['status'] || body['status'] == 'success') && !body['error']
    end

    def error_message
      return body['error'] if response.code == 200

      response.message
    end

    def body
      @body ||= JSON.parse(response.body)
    end
  end
end
