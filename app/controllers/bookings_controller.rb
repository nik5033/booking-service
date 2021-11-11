class BookingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # GET /bookings/1 or /bookings/1.json
  def show 
    render json: { result: BookingService.new(params).valid? }
  end

  # POST /bookings
  def create
    #Price not done

    @booking = Booking.new(event_date: booking_params[:event_date].to_date,
                           status: 1,
                           ticket_category: booking_params[:ticket_category]
    )

    if @booking.save
      render json: { booking_id: @booking.id }, status: :created
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    return render json: {resuls: "Booking invalid"}, status: :not_found unless BookingService.new(params).valid?
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
