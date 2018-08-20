class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(username: params[:username], password: params[:password])
    if user.valid?
      render json: { token: issue_token({ id: user.id }) }
    else
      render json: { error: 'Cannot create user!' }
    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: { token: issue_token({ id: user.id }) }
    else
      render json: { error: 'Cannot find or authenticate user.' }
    end
  end

  def get_current_user
    if current_user
      render json: { username: current_user.username, id: current_user.id }
    else
      render json: { error: 'no user' }
    end
  end

  def get_events
    if current_user && params[:id].to_i == current_user.id
      my_events = current_user.events
      render json: my_events
    else
      render json: { error: 'Not authorized!' }
    end
  end

  def set_events
    if current_user && params[:id].to_i == current_user.id
      render json: current_user.events
    else
      render json: { error: 'Not authorized!' }
    end
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user
  end
end
