module API
  class Root < Grape::API
    prefix 'api'
    format :json
    mount API::Ver1::Root
  end
end
