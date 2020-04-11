require 'rails_helper'

describe ItemsController, type: :controller do

  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "renders the :edit template" do
      item = create(:item)
      get :edit, params: {  id: item }
      expect(response).to render_template :edit
    end

    it "@tweet contains the correct value" do
      item = create(:item)
      get :edit, params: {  id: item }
      expect(assigns(:item)).to eq item
    end
  end

end