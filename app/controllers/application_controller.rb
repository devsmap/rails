class ApplicationController < ActionController::Base  
  
  include HttpAcceptLanguage::AutoLocale
  include Response
  
  layout :resolve_layout

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session

  private

    def resolve_layout
      "application"
    end
      
end
