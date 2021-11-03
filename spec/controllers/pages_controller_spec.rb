require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET#welcome' do
    context 'no user is logged in' do
      before do
        get :welcome
      end
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      it 'renders welcome template' do
        expect(response).to render_template(:welcome)
      end
    end

    context 'user is logged in' do
      let (:user) { FactoryBot.create(:user) }
      before do
        sign_in user
        get :welcome
      end
      it 'returns http status 302' do
        expect(response.status).to eq(302)
      end
      it 'redirects to home page' do
        expect(response).to redirect_to(dashboard_url)
      end
    end
  end

  describe 'GET#dashboard' do
    let (:user) { FactoryBot.create(:user) }
    before do
      sign_in user
      get :dashboard
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders welcome template' do
      expect(response).to render_template(:dashboard)
    end
  end
end