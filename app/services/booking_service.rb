class BookingService
  attr_reader :params
  
  def initialize(params)
    @params = params
  end

  def valid?
    booking = Booking.find(params[:id])

    if Time.now - booking[:created_at].min < 5*60 and booking[:status] == 1
      return true 
    else
      booking.update(status: 0)
      return false
    end
  end
end