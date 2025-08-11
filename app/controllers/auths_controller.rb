class AuthsController < ApplicationController
  def create
    name = params[:name]
    password = params[:password]

    if name.present? && password.present?
      payload = { user_id: name, exp: Time.now.to_i + 2 * 3600 }
      token = JWT.encode(payload, Rails.application.secret_key_base, "HS256")

      render json: { token: token, name: name }
    else
      render json: { error: "veja se inseriu tudo correto" }, status: :unauthorized
    end
  end
end
