class CommentsController < ApplicationController
  before_action :set_comment, only: [:show]
  before_action :set_activity, only: [:create]
  before_action :authorize, only: [:create]
  before_action :check_author, only: [:delete]

  # GET /comments
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.activity = @activity
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def delete
    @comment.destroy
    render json: {success: true}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_activity
      @activity = Activity.find(params[:activity_id])
    end

    def authorize
      @user = AuthorizeController.authorize(request)
      if @user == nil 
        render status: :forbidden 
      end
    end

    def check_author
      set_activity
      set_comment
      @user = AuthorizeController.authorize(request)
      if @user == nil or (@user != @activity.user and @user != @comment.user)
        render status: :forbidden 
      end
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.permit(:user_id, :activity_id, :title, :body)
    end
end
