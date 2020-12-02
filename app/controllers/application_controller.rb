class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  protected

  def authenticate_from_api_token
    @client = Client.find_by(api_key: params[:api_key])
    head(401) if @client.nil?
  end

  def render_404
    render file: "#{Rails.root}/public/404", formats: [:html], status: 404, layout: false
  end
end
