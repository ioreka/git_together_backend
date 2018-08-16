require 'rest-client'
require 'json'

class Api::V1::EventsController < ApplicationController

  def get_events
    groups = RestClient.get "https://api.meetup.com/find/groups?photo-host=public&location=#{params[:location]}&text=#{params[:topic]}&page=5&sign=true&key=5b1a3d69774fb217b6315436e6418"
    groups = JSON.parse(groups)

    events = []
    groups.each do |group|
      group_events = RestClient.get "https://api.meetup.com/#{group["urlname"]}/events?photo-host=public&page=1&sign=true&key=5b1a3d69774fb217b6315436e6418"
      group_events = JSON.parse(group_events)
      events << group_events
    end

    events = events.select do |event|
      event.length > 0
    end
    events = events.to_json
    render json: events
  end

  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:name, :group_name, :description, :date, :time, :venue_address, :meetup_id)
    end

end
