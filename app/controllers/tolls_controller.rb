class TollsController < ApplicationController

  def index
    #@tolls = Toll.all
  end

  def calculate

    @vehicle = Vehicle.new(params.permit(:govt,:vehicle_number,:vehicle_type,:wheels,:axle))
    if @vehicle.save

      @toll = Toll.get_toll(@vehicle)
    else
      @error = @vehicle.errors.full_messages
    end
    respond_to do |format|
      format.js { render 'tolls/calculate'}
    end
  end

end
