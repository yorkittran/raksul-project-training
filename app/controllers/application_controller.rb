# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ErrorHandler

  # rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
end
