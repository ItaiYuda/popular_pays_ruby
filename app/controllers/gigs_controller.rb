class GigsController < ApplicationController
  before_action :set_creator, only: [:show, :update, :destroy]

  # GET /gigs
  def index
    brand_name = params[:brand_name]
    creator_id = params[:creator_id]
    @gigs = Gig.all
    @gigs = @gigs.where(brand_name: brand_name) if brand_name
    @gigs = @gigs.where(creator_id: creator_id) if creator_id

    render json: @gigs
  end

  # GET /gigs/:id
  def show
    # param! :relationship, String, in: ["gig_payment", "creator"]

    render json: @gig, include: params[:include]
  end

  # POST /gigs
  def create
    @gig = Gig.new(gig_params)
    @gig.state = 'applied'
    if @gig.save
      render json: @gig, status: :created, location: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gigs/1
  def update
    if @gig.update(gig_params)
      render json: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creator
      @gig = Gig.find(params[:id])
    end
    # Only allow a trusted parameter "white list" through.
    def gig_params
      params.require(:gig).permit(:brand_name, :creator_id, :state)
    end
end
