class ApplicationController < ActionController::API
  # rescue_from ActionController::RoutingError, with: :routing_error
  rescue_from AASM::InvalidTransition, with: :invalid_transition
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def routing_error
    render json: { error: 'routing error' }.to_json, status: :not_found
  end

  private

  def invalid_transition(exception)
    render json: { error: exception.message }.to_json, status: :bad_request
  end

  def record_not_found(exception)
    render json: { error: exception.message }.to_json, status: :not_found
  end
end
