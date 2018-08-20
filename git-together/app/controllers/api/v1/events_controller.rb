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



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by(params[:meetup_id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.permit(:name, :group_name, :description, :local_date, :local_time, :address, :meetup_id, :meetup_link)
    end

end
