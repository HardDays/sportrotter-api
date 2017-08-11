class MessagesController < ApplicationController
  before_action :authorize, only: [:create, :show, :show_sent, :show_received, :mark_read]
  before_action :set_message, only: [:show, :mark_read]

  # GET /messages/get/:id
  def show
    if @message.to == @user or @message.from == @user
      render json: @message
    else
      render status: :unauthorized 
    end
  end

  # GET /messages/get_sent
  def show_sent
    render json: @user.sent_messages.limit(params[:limit]).offset(params[:offset])
  end

  # GET /messages/get_received
  def show_received
    render json: @user.received_messages.limit(params[:limit]).offset(params[:offset])
  end

  # POST /messages/mark_read/:id
  def mark_read
    if @message.to == @user
      @message.is_read = true
      if @message.save
        render status: :ok
      else
        render @message.errors
      end
    else
      render status: :unauthorized 
    end
  end

  # POST /messages/create
  def create
    @message = Message.new(message_params)
    @message.from = @user

    to = nil
    if params[:to_id]
      to = User.find(params[:to_id])
    end
    @message.to = to

    @message.is_read = false
  
    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  # def update
  #   if @message.update(message_params)
  #     render json: @message
  #   else
  #     render json: @message.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /messages/1
  # def destroy
  #   @message.destroy
  # end

  private

    def authorize
      @user = AuthorizeController.authorize(request)
      if @user == nil
        render status: :unauthorized 
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.permit(:title, :body)
    end
end
