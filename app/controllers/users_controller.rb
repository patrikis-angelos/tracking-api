class UsersController < ApplicationController
  before_action :authorized, except: %i[create login show auto_login]

  def auto_login
    id = cookies[:user_id]
    if id
      token = encode_token({ user_id: id })
      render json: { token: token }
    else
      render json: { error: 'User not logged in' }
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = encode_token({ user_id: @user.id })
      cookies[:user_id] = { value: @user.id, http_only: true }
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  def login
    @user = User.find_by(name: params[:name])

    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      cookies[:user_id] = { value: @user.id, http_only: true }
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  def logout
    cookies.delete :user_id
  end

  private

  def user_params
    params.permit(:name, :password)
  end
end
