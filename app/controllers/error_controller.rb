class ErrorController < ApplicationController
  def catch_routing_error
    raise ActionController::RoutingError, params[:path]
  end
end
