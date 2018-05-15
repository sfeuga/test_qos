# frozen_string_literal: true

##
# ApplicationController class
#
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def not_found
    head 404, 'content_type' => 'text/plain'
  end
end
