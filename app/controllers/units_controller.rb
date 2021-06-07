class UnitsController < ApplicationController
  def index
    @units = Unit.all
    render json: @units, status: :ok
  end
end
