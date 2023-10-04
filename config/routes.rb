Rails.application.routes.draw do
  get "/poker_checker" => "poker_hand_checker#index"
  post "poker_checker/check" => "poker_hand_checker#check"
  # grape api
  mount API::Root => "/"
end
