class TollsController < ApplicationController
  before_action :set_toll, only: [:show, :edit, :update, :destroy]

  # GET /tolls
  # GET /tolls.json
  def index
    @tolls = Toll.all
  end

  # GET /tolls/1
  # GET /tolls/1.json
  def show
  end

  # GET /tolls/new
  def new
    @toll = Toll.new
  end

  # GET /tolls/1/edit
  def edit
  end

  # POST /tolls
  # POST /tolls.json
  def create
    @toll = Toll.new(toll_params)

    respond_to do |format|
      if @toll.save
        format.html { redirect_to @toll, notice: 'Toll was successfully created.' }
        format.json { render :show, status: :created, location: @toll }
      else
        format.html { render :new }
        format.json { render json: @toll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tolls/1
  # PATCH/PUT /tolls/1.json
  def update
    respond_to do |format|
      if @toll.update(toll_params)
        format.html { redirect_to @toll, notice: 'Toll was successfully updated.' }
        format.json { render :show, status: :ok, location: @toll }
      else
        format.html { render :edit }
        format.json { render json: @toll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tolls/1
  # DELETE /tolls/1.json
  def destroy
    @toll.destroy
    respond_to do |format|
      format.html { redirect_to tolls_url, notice: 'Toll was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_toll
      @toll = Toll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def toll_params
      params.fetch(:toll, {})
    end

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
