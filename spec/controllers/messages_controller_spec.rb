require 'rails_helper'

describe MessagesController do

  let(:group) { create(:group) }
  let(:groups) { create_list(:group, 3, user_ids: user.id) }
  let(:user) { create(:user) }
  let(:message) { create(:message) }
  let(:messages) { create_list(:message, 3, user_id: user.id, group_id: group.id) }

  describe 'user sign_in' do
    before do
      sign_in user
    end
    after do
      sign_out user
    end

    describe 'GET #index' do
      it "assigns the requested contact to @groups" do
        get :index, params: {group_id: group.id }
        expect(assigns(:groups)).to match(groups)
      end

      it "assigns the requested contact to @group" do
        get :index, params: { group_id: group.id }
        expect(assigns(:group)).to eq group
      end

      it "assigns the requested contact to @messages" do
        get :index, params: { group_id: group.id }
        expect(assigns(:messages)).to match(messages)
      end

      it "renders the index template" do
        get :index, params: { group_id: group.id }
        expect(response).to render_template :index
      end
    end

    describe 'POST #create' do
      context 'success to save' do
        it "save a new mmessage" do
          expect {
            post :create, params: { group_id: group.id, user_id: user.id, message: attributes_for(:message) }
          }.to change(Message, :count).by(1)
        end
        it 'redirect_to group_messages_path' do
          post :create, params: { group_id: group.id, user_id: user.id, message: attributes_for(:message) }
          expect(response).to redirect_to group_messages_path
        end
      end

      context 'fails to save' do
        it 'can not save a new message' do
          expect{
            post :create, params: { group_id: group.id, user_id: user.id, message: attributes_for(:message, body: nil) }
          }.not_to change(Message, :count)
        end
        it 'redirect_to group_messages_path' do
          post :create, params: { group_id: group.id, user_id: user.id, message: attributes_for(:message, body: nil) }
          expect(response).to render_template :index
        end
      end
    end
  end
end
