class GigPaymentsController < ApplicationController
  before_action :set_gig_payment, only: [:set_complete]

  def set_complete
    @gig_payment.set_complete!
    render json: @gig_payment
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gig_payment
    @gig_payment = GigPayment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  # def gig_params
  #   params.require(:gig).permit(:brand_name, :creator_id, :state)
  # end
end
