class Api::HealthcheckController < ApplicationController
  def healthcheck
    ActiveRecord::Base.connection.execute('SELECT 1')
    render json: { message: 'OK' }, status: :ok
  end
end
