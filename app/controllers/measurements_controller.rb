class MeasurementsController < ApplicationController
  def index
    @measurements = current_user.measurements.with_units
    data = []
    @measurements.each do |m|
      item = {}
      item['unit'] = m.unit
      item['value'] = m
      data << item
    end
    render json: { measurements: data, status: :ok }
  end

  def create
    @measurement = current_user.build(measurement_params)
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
