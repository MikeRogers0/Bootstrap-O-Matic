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
        get '/:action'
      end
    end
  end

  root to: redirect('/styleguides/bootstrap/4')
end
