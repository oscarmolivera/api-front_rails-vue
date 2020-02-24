class RecordsController < ApplicationController
  before_action :set_record, only: %i[show update destroy]
  before_actrion :authorize_action_request!

  # GET /records
  def index
    @records = current_user.records.all

    render json: @records
  end

  # GET /records/1
  def show
    render json: @record
  end

  # POST /records
  def create
    @record = current_user.records.new(record_params)

    if @record.save
      render json: @record, status: :created, location: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /records/1
  def update
    if @record.update(record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /records/1
  def destroy
    @record.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = current_user.records.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def record_params
    params.require(:record).permit(:tittle, :year, :user_id)
  end
end
