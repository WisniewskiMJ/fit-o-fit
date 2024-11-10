require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  let(:user) { create(:user) }
  let(:start) { create(:place, address: start_address) }
  let(:start_address) { 'Towarowa 2, Warszawa, Polska' }
  let(:finish) { create(:place, address: finish_address) }
  let(:finish_address) { 'Puławska 35, Warszawa, Polska' }
  let(:activity) { create(:activity, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    before do
      start
      finish
      activity
    end

    it 'assigns @activities and renders the index template' do
      get :index
      expect(assigns(:activities)).to eq([activity])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:start) { 'Towarowa 2, Warszawa, Polska' }
    let(:finish) { 'Puławska 35, Warszawa, Polska' }
    let(:params) { { start_address: start, finish_address: finish, day: Date.today } }
    let(:activity) { create(:activity) }
    let(:service_result) { OpenStruct.new(created?: true, payload: activity) }

    context 'when create succeeded' do
      before do
        create :place, address: start
        create :place, address: finish
        allow(ActivityServices::ActivityCreator).to receive(:call).and_return(service_result)
        post(:create, params: { activity: params })
      end

      it 'returns http status 302' do
        expect(response).to have_http_status(302)
      end

      it 'redirects to root url' do
        expect(response).to redirect_to(root_url)
      end

      it 'displays success flash message' do
        expect(flash[:notice]).to be_present
      end
    end

    context 'when create failed' do
      let(:failed_activity) { build(:activity) }
      let(:failed_service_result) { OpenStruct.new(created?: false, payload: failed_activity) }

      before do
        start
        finish
        failed_activity.errors.add(:errors, message: 'error')
        allow(ActivityServices::ActivityCreator).to receive(:call).and_return(failed_service_result)
        post(:create, params: { activity: params })
      end

      it 'returns http status 302' do
        expect(response).to have_http_status(302)
      end

      it 'redirects to new activity url' do
        expect(response).to redirect_to(new_activity_url)
      end

      it 'displays alert flash message' do
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'GET #show' do
    context 'when activity exists' do
      before do
        start
        finish
        activity
      end

      it 'assigns @activity and renders the show template' do
        get :show, params: { id: activity.id }
        expect(assigns(:activity)).to eq(activity)
        expect(response).to render_template(:show)
      end
    end

    context 'when activity does not exist' do
      it 'redirects to activities url' do
        get :show, params: { id: 'non-existent-id' }
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      start
      finish
      activity
    end
    it 'deletes the activity and redirects' do
      expect { delete :destroy, params: { id: activity.id } }.to change(Activity, :count).by(-1)
    end
  end
end
