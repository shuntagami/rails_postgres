class ApplicationController < ActionController::Base
  include AppErrorResponder

  protect_from_forgery with: :exception
end
