class Mypage::SendingDestinationsController < ApplicationController
  def edit
    @sending_destinations = SendingDestination.find_by(user_id: current_user.id)
  end

  def update
    @sending_destinations = SendingDestination.find_by(user_id: current_user.id)
    atri = @sending_destinations.attributes
    coulums = ["destination_family_name", "destination_first_name", "destination_family_name_kana", "destination_first_name_kana", "post_code, prefecture_id", "city", "house_number", "building_name", "phone_number"]
    change_coulum = 0
    coulums.each do |coulum|
      destination_fm = atri[coulum]
      destination_fm2 = sending_destination_params[coulum]
      if destination_fm != destination_fm2
        change_coulum += 1
      # flash[:notice] = "変更がありません"
      # render :edit
      end
    end
    # binding.pry
    if change_coulum == 0
      @sending_destinations.errors[:base] << "変更がありません"
      flash.now[:alert] = @sending_destinations.errors.full_messages
      render :edit
      # redirect_to mypage_sending_destinations_edit_path, notice: "変更がありません"
    else
      @sending_destinations.update(sending_destination_params)
      if @sending_destinations.save
        @sending_destinations.errors[:base] << "登録内容を更新しました"
        flash.now[:alert] = @sending_destinations.errors.full_messages
        render :edit
      else
        flash.now[:alert] = @sending_destinations.errors.full_messages
        render :edit
      end
    end
  end

  private

  def sending_destination_params
    params.require(:sending_destination).permit(:destination_family_name, :destination_first_name, :destination_family_name_kana, :destination_first_name_kana, :post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number)
  end
end
