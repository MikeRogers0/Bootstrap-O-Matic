Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :css do
    namespace :bootstrap, path: 'bootstrap' do
      resource :v4, path: '4', controller: 'v4', only: [:show]
    end
  end

  namespace :styleguides do
    namespace :bootstrap, path: 'bootstrap' do
      resource :v4, path: '4', controller: 'v4', only: [:show] do
        [:buttons, :alerts, :typography, :tables, :forms, :progress].each do |action|
          get "/#{action}", action: action
        end
      end
    end
  end

  resource :css_parsers, only: [:create], as: :css_parser, path: 'css-parser'
  resource :css_randoms, only: [:create], as: :css_random, path: 'css-random'

  root to: 'landing#index'
end
