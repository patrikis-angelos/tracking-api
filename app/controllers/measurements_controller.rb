class MeasurementsController < ApplicationController
  def index
    @units = Unit.all.with_measurements
    data = []
    @units.each do |u|
      item = {}
      item['unit'] = u
      item['measurements'] = u.measurements
      data << item
    end
    render json: { data: data, status: :ok }
  end

  def create
    @measurement = current_user.measurements.build(measurement_params)
    @measurement.unit_id = params[:unit_id]
    if @measurement.save
      render json: { measurement: @measurement }
    else
      render json: { error: 'Invalid submission' }
    end
  end

  def update
    @measurement = Measurement.find(params[:id])
    @measurement.update(measurement_params)
    render json: { measurement: @measurement }
  end

  def destroy
    @measurement = Measurement.find(params[:id])
    @measurement.destroy
  end

  private

  def measurement_params
    params.permit(:value)
  end
end
