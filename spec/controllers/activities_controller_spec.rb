require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  let(:user) { create(:user) }
  describe 'GET #index' do
    before do
      sign_in user
      get :index
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  describe 'POST#create' do
    context 'with valid params' do
      let(:start) { "Towarowa 1, Warszawa, Polska" }
      let(:finish) { "Puławska 35, Warszawa, Polska" }
      let(:valid_params) { { start_address: start, finish_address: finish, day: Date.today } }
      before do
        sign_in user
        post :create, params: { activity: valid_params }
      end
      it 'returns http status 302' do
        expect(response).to have_http_status(302)
      end
      it 'redirects to root url' do
        expect(response).to redirect_to(root_url)
      end
      it 'creates a new activity' do
        expect{ post :create, params: { activity: valid_params } }.to change { Activity.count }.by(1)
      end
      it 'displays success flash message' do
        expect(flash[:notice]).to be_present 
      end
    end

      context 'with invalid params' do
      let(:start) { "Towarowa 1" }
      let(:finish) { "Puławska 35, Warszawa, Polska" }
      let(:invalid_params) { { start_address: start, finish_address: finish, day: Date.today } }
      before do
        sign_in user
        post :create, params: { activity: invalid_params }
      end
      it 'returns http status 302' do
        expect(response).to have_http_status(302)
      end
      it 'redirects to new activity url' do
        expect(response).to redirect_to(new_activity_url)
      end
      it 'does not create a new activity' do
        expect{ post :create, params: { activity: invalid_params } }.not_to change { Activity.count }
      end
      it 'displays alert flash message' do
        expect(flash[:alert]).to be_present 
      end
    end
  end

  describe 'GET #show' do
    let(:start) { create(:place) }
    let(:finish) { create(:place, address: "Puławska 35, Warszawa, Polska") }
    let(:activity) { create(:activity, user_id: user.id, start_id: start.id, finish_id: finish.id ) }
    before do
      sign_in user
      get :show, params: { id: activity.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end
end