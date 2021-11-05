require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe "GET#show" do
      let(:user) { create(:user) }
      before do
        sign_in user
        get :show, params: { id: user.id }
      end  
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      it 'renders user show page' do
        expect(response).to render_template(:show)
      end
    end

end