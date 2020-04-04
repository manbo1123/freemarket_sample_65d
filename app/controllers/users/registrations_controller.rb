# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new
    @user = User.new
  end

  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
    super
    
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @sending_destination = @user.build_sending_destination
    render :new_sending_destination
  end

  def create_sending_destination
    @user = User.new(session["devise.regist_data"]["user"])
    @sending_destination = SendingDestination.new(sending_destination_params)
    unless @sending_destination.valid?
      flash.now[:alert] = @sending_destination.errors.full_messages
      render :new_sending_destination and return
    end
    @user.build_sending_destination(@sending_destination.attributes)

    if @user.save
      sign_in(:user, @user)
      redirect_to new_card_path
    else
      render :new_sending_destination
    end
  end

  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  def sending_destination_params
    params.require(:sending_destination).permit(:destination_family_name, :destination_first_name, :destination_family_name_kana, :destination_first_name_kana, :post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number)
  end

end
