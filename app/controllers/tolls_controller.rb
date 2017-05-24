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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_toll
      @toll = Toll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def toll_params
      params.fetch(:toll, {})
    end
end
