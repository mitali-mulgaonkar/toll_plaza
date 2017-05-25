class TollsController < ApplicationController

  def index
    #@tolls = Toll.all
  end

  def calculate
    govt = params[:govt]
    vehicle_number = params[:number]
    type = params[:type]
    wheels = params[:wheels]
    axle = params[:axle]

    valid,msg = validate(vehicle_number,wheels.to_i,axle.to_i)
    if valid
      if vehicle_number.start_with?('MH') || govt.to_i == 1
        @toll = 0
      else
        @toll = get_toll(type.to_i, wheels.to_i, axle.to_i)
      end
    else
      @error = msg
    end
    respond_to do |format|
      format.js { render 'tolls/calculate'}
    end
  end

  def get_toll(type, wheels, axle)
    toll = 0
    if axle >= 2
      toll = 500 + (100 * axle)
    elsif wheels == 2
      toll = 20
    elsif wheels == 3
      toll = 50
    elsif wheels == 4 && type == 0
      toll = 100
    elsif wheels == 4 && type == 1
      toll = 200
    elsif wheels == 6
      toll = 500
    end
    return toll
  end


  private

    def validate(vehicle_number,wheels,axle)
      valid = true
      msg = ""
      if vehicle_number.blank? || !(/^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$/.match(vehicle_number))
        valid = false
        msg += "Please enter valid vehicle number. "
      end

      if wheels >=4 && (axle < 0 || axle > 20)
        valid = false
        msg += "Please enter valid axle number. "
      end
      return valid,msg
    end
end
