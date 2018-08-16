require 'rest-client'
require 'json'

class Api::V1::EventsController < ApplicationController

  def get_events
    # byebug
    # response = RestClient.get "https://api.meetup.com/find/upcoming_events?&sign=true&photo-host=public&topic_category=#{params[:topic]}&key=554a2e4462647014b1775457e76311"
    groups = RestClient.get "https://api.meetup.com/find/groups?photo-host=public&location=#{params[:location]}&text=#{params[:topic]}&page=5&sign=true&key=5b1a3d69774fb217b6315436e6418"
    groups = JSON.parse(groups)
    # print groups
    events = []
    groups.each do |group|
      group_events = RestClient.get "https://api.meetup.com/#{group["urlname"]}/events?photo-host=public&page=1&sign=true&key=5b1a3d69774fb217b6315436e6418"
      group_events = JSON.parse(group_events)
      events << group_events
    end
    # byebug
    events = events.select do |event|
      event.length > 0
    end
    events = events.to_json
    render json: events
  end

end
