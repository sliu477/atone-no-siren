module API
  module Ver1
    class Root < Grape::API
      version 'v1', using: :path
      format :json
      default_format :json
      content_type :json, "application/json"
      content_type :xml, 'application/xml'
      content_type :javascript, 'application/javascript'
      content_type :txt, 'text/plain'
      content_type :html, 'text/html'
    end
  end
end
