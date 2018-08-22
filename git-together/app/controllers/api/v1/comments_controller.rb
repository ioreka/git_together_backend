class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]



# GET /comments
def index
  @comments = Comment.all
  print "Comments at allll #{@comments}"
  @comments = @comments.select do |c|
    c["meetup_id"] == params["meetup_id"]
  end
  print "Comments SELECTEEEEDDD #{@comments}"
  render json: @comments
end

def show
  render json: @comment
end

# POST /comments
def create
   c = params[:comment]
  print c
  comment = Comment.new(:comment => c["comment"], :username => c["username"], :user_id => c["user_id"], :event_id => c["event_id"], :meetup_id => c["meetup_id"])
  if comment.save
    render json: comment
  else
    render json: comment.errors, status: :unprocessable_entity
  end
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :event_id, :username, :meetup_id)
  end
end
