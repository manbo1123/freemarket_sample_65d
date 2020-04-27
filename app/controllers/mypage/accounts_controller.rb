class Mypage::AccountsController < ApplicationController
  before_action :authenticate_user

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    params[:user][:birthday] = birthday_join
    @user = User.find_by(id: current_user.id)
    atri = @user.attributes
    coulums = ["nickname", "email", "family_name", "first_name", "family_name_kana", "first_name_kana", "birthday"]
    change_coulum = 0
    coulums.each do |coulum|
      user_before = atri[coulum]
      user_after = account_params[coulum]
      if user_before != user_after
        change_coulum += 1
      end
    end
    if change_coulum == 0
      @user.errors[:base] << "変更がありません"
      flash.now[:alert] = @user.errors.full_messages
      render :edit
    else
      @user.update(account_params)
      if @user.save
        @user.errors[:base] << "登録内容を更新しました"
        flash.now[:alert] = @user.errors.full_messages
        render :edit
      else
        flash.now[:alert] = @user.errors.full_messages
        render :edit
      end
    end
  end

  def edit_password
    @user = User.find_by(id: current_user.id)
  end

  def update_password
    @user = User.find_by(id: current_user.id)
    if @user.update_with_password(password_params)
      redirect_to user_session_path
    else
      @user.errors[:password] << "登録内容が更新できませんでした"
      flash.now[:alert] = @user.errors.full_messages
      render :edit_password
    end
  end

  private

  def account_params
    params.require(:user).permit(:nickname, :email, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def birthday_join
    if params[:user]["birthday(1i)"].empty? && params[:user]["birthday(2i)"].empty? && params[:user]["birthday(3i)"].empty?
      return
    end
    Date.new params[:user]["birthday(1i)"].to_i, params[:user]["birthday(2i)"].to_i, params[:user]["birthday(3i)"].to_i
  end

end
