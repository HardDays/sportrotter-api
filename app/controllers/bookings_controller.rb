class BookingsController < ApplicationController
  # before_action :set_booking, only: [:show, :update, :destroy]
  before_action :authorize, only: [:show, :index, :create, :get_my_bookings]
  before_action :authorize_self, only: [:update, :delete]
  before_action :authorize_act, only: [:get_activity_bookings, :validate_booking]
  before_action :check_activity_num, only: [:create, :update]


  # GET /bookings
  def index
    @bookings = Booking.all

    render json: @bookings.limit(params[:limit]).offset(params[:offset])
  end

  # GET /bookings/1
  def show
    render json: @booking
  end

  # GET /bookings/get_activity_bookings/:id
  def get_activity_bookings
    render json: @activity.bookings.limit(params[:limit]).offset(params[:offset])
  end

  # GET /bookings/get_my_bookings
  def get_my_bookings
    render json: @user.bookings.limit(params[:limit]).offset(params[:offset])
  end

  # POST /bookings/validate_booking
  def validate_booking
    @booking = Booking.find(params[:booking_id])
    @booking.is_validated = true
    render json: @booking
  end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)
    @booking.user = @user
    @booking.is_validated = false
    @booking.date = DateTime.parse(params[:date]) if params[:date]
    if @booking.save
      render json: @booking, status: :created
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1
  def update
    @booking.is_validated = false
    if @booking.update(booking_params_upd)
      @booking.date = Date.new(params[:date]) if params[:date]
      @booking.save
      render json: @booking
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookings/1
  def delete
    @booking.destroy
    render json: {success: true}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def authorize
      @user = AuthorizeController.authorize(request)
      if @user == nil
        render status: :forbidden 
      end
    end

    def authorize_self
      set_booking
      @user = AuthorizeController.authorize(request)
      if @user == nil or @user != @booking.user
        render status: :forbidden 
      end
    end

    def authorize_act
      @activity = Activity.find(params[:id])
      @user = AuthorizeController.authorize(request)
      if @user == nil or @user != @activity.user
        render status: :forbidden 
      end
    end

    def check_activity_num
      @activity = Activity.find(params[:activity_id])
      date = DateTime.parse(params[:date])
      @bookings = Booking.where(activity_id: params[:activity_id], date: date.all_day)
      if @activity.calendar_dates.find{|c| c.date == date} == nil
        render json: {error: "no such date for booking"}, status: :unprocessable_entity and return
      end
      if @bookings.sum{|b| b.num_of_participants} >= @activity.num_of_bookings
        render json: {error: "number of bookings reached"}, status: :unprocessable_entity
      end
    end


    # Only allow a trusted parameter "white list" through.
    def booking_params
      params.permit(:activity_id, :date, :num_of_participants)
    end

    def booking_params_upd
      params.permit(:date, :num_of_participants)
    end
end
