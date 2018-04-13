#Rails.application.config.session_store ActionDispatch::Session::CacheStore, expire_after: 1.month
Rails.application.config.session_store :cookie_store, key: '_SOM_session' # , domain: :all
