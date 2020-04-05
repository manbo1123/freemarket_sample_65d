class Mypage::AccountsController < ApplicationController
  before_action :authenticate_user

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    params[:user][:birthday] = birthday_join
    @user = User.find_by(id: current_user.id)
    # user_params["birthday"] = birthday_join
    atri = @user.attributes
    coulums = ["nickname", "email", "family_name", "first_name", "family_name_kana", "first_name_kana", "birthday"]
    change_coulum = 0
    coulums.each do |coulum|
      user_before = atri[coulum]
      user_after = user_params[coulum]
      if user_before != user_after
        change_coulum += 1
      end
    end
    if change_coulum == 0
      @user.errors[:base] << "変更がありません"
      flash.now[:alert] = @user.errors.full_messages
      render :edit
    else
      @user.update(user_params)
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

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday)
  end

  def birthday_join
    if params[:user]["birthday(1i)"].empty? && params[:user]["birthday(2i)"].empty? && params[:user]["birthday(3i)"].empty?
      return
    end
    Date.new params[:user]["birthday(1i)"].to_i, params[:user]["birthday(2i)"].to_i, params[:user]["birthday(3i)"].to_i
  end

end
