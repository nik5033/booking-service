class BookingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # GET /bookings/1 or /bookings/1.json
  def show 
    render json: { result: BookingService.new(params).valid? }
  end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)
      #not done
      if @booking.save
        format.json { render json: { booking_id: @booking.id }, status: :created}
      else
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    if Booking.find(params[:id]).update(status: 0)
      render json: {result: 'Ok'}
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def booking_params
      params.fetch(:booking, {})
    end
end
