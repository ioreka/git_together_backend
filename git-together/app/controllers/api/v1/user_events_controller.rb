class Api::V1::UserEventsController < ApplicationController
  before_action :set_userevent, only: [:show, :update, :destroy]

  # GET /userevents
  def index
    @userevents = UserEvent.all

    render json: @userevents
  end

  # GET /userevents/1
  def show
    render json: @userevent
  end

  # POST /userevents
  def create
    @userevent = UserEvent.new(userevent_params)

    if @userevent.save
      render json: @userevent, status: :created, location: @userevent
    else
      render json: @userevent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /userevents/1
  def update
    if @userevent.update(userevent_params)
      render json: @userevent
    else
      render json: @userevent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /userevents/1
  def destroy
    @userevent.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userevent
      @userevent = UserEvent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def userevent_params
      params.require(:userevent).permit(:user_id, :event_id)
    end
end
