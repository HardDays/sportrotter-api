class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show]
  before_action :authorize, only: [:create]
  before_action :check_author, only: [:update, :delete]
  before_action :check_rate, only: [:rate]
  before_action :check_unrate, only: [:unrate]


  # GET /activities/get_all
  def index
    @activities = Activity.all

    filters = ['user_id']
    filters.each do |filter|
      @activities = @activities.where(filter => params[filter]) if params[filter] != nil
    end

    filters = ['title', 'description', 'address']
    filters.each do |filter|
      @activities = @activities.where("#{filter} ILIKE ?", "%#{params[filter]}%") if params[filter] != nil
    end

    if params[:dates] != nil
      dates = params[:dates].collect{|d| DateTime.parse(d)}
      @activities = @activities.joins(:calendar_dates).where("calendar_dates.date IN (?)", dates)
    end

    render json: @activities.limit(params[:limit]).offset(params[:offset])
  end

  # GET /activities/get/:id
  def show
    render json: @activity
  end

  # POST /activities/rate
  def rate
    @rate = Rate.new(rate_params)
    @rate.user = @user
    if @rate.save
      render json: @rate, status: :created
    else
      render json: @rate.errors, status: :unprocessable_entity
    end

  end

  # POST /activities/unrate
  def unrate
    @rate = Rate.find_by(user_id: @user.id, activity_id: params[:activity_id])
    if @rate
      @rate.destroy
      render json: {success: true}, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  # POST /activities/create
  def create
    @activity = Activity.new(activity_params)
    @activity.user = @user

    if params[:image]
        image = Image.new(base64: params[:image])
        @activity.image = image
    end

    if @activity.save
      if params[:calendar]
        params[:calendar].each do |date|
          calendar_date = CalendarDate.new(date: DateTime.parse(date), activity: @activity)
          calendar_date.save
        end
      end

      render json: @activity, status: :created
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activities/update/:id
  def update
    
    if @activity.image
      @activity.image.delete
    end
    if params[:image]
        image = Image.new(base64: params[:image])
        @activity.image = image
    end

    if @activity.update(activity_params)
      @activity.calendar_dates.delete_all

      if params[:calendar]
        params[:calendar].each do |date|
          calendar_date = CalendarDate.new(date: DateTime.parse(date), activity: @activity)
          calendar_date.save
        end
      end

      @activity.reload
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /activities/delete/:id
  def delete
    @activity.destroy
    render json: {success: true}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def authorize
      @user = AuthorizeController.authorize(request)
      if @user == nil or @user.user_type == 'client'
        render status: :forbidden 
      end
    end

    def check_rate
      @user = AuthorizeController.authorize(request)
      if @user == nil
        render status: :forbidden 
      else
        @activity = Activity.find(params[:activity_id])
        booking = @user.bookings.find{|b| b.activity_id == params[:activity_id]}
        has_rate = @activity.rates.find{|r| r.activity_id == params[:activity_id] and r.user_id == @user.id}
        if booking == nil or booking.date > Time.now or has_rate
          render json: {"error": "cannot rate this booking"}, status: :unprocessable_entity
        end
      end
    end

    def check_unrate
      @user = AuthorizeController.authorize(request)
      if @user == nil
        render status: :forbidden         
      end
    end


    def check_author
      set_activity
      @user = AuthorizeController.authorize(request)
      if @user == nil or @user.user_type == 'client' or @user != @activity.user
        render status: :forbidden 
      end
    end

    # Only allow a trusted parameter "white list" through.
    def activity_params
      params.permit(:title, :price, :num_of_bookings, :address, :description)
    end

    # Only allow a trusted parameter "white list" through.
    def rate_params
      params.permit(:activity_id, :rate)
    end
end
