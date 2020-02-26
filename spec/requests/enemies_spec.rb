require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe 'GET /enemies' do
    context 'when index' do
      let!(:enemies) { create_list(:enemy, 5) }

      before(:each) do
        get '/enemies'
      end

      it 'returns all records' do
        expect(response.body).to eq(enemies.to_json)
      end
    end

    context 'when show' do
      let!(:enemy) { create(:enemy) }

      before(:each) do
        get "/enemies/#{enemy.id}"
      end

      it 'returns the enemy' do
        expect(response.body).to eq(enemy.to_json)
      end
    end
  end

  describe "PUT /enemies" do
    context 'when the enemy exists' do
      let(:enemy)            { create(:enemy) }
      let(:enemy_attributes) { attributes_for(:enemy) }

      before(:each) do
        put "/enemies/#{enemy.id}", params: enemy_attributes
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the record' do
        expect(enemy.reload).to have_attributes(enemy_attributes)
      end

      it 'returns the enemy updated' do
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
      end
    end

    context 'when the enemy does not exist' do
      before(:each) do
        put '/enemies/0', params: attributes_for(:enemy)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end

    describe 'POST /enemies' do
      context 'when has valid parameters' do
        let(:enemy_attributes) { attributes_for(:enemy) }
        before { post enemies_path, params: enemy_attributes }

        it 'creates an enemy' do
          expect(Enemy.last).to have_attributes(enemy_attributes)
        end

        it 'returns 201 status code' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when has no valid parameters' do
        it 'does not create a enemy' do
          expect do
            post enemies_path, params: { name: '', power_base: '', power_step: '', level: '', kind:'' }
          end.to_not change(Enemy, :count)
        end
      end
    end

    describe 'DELETE /enemies' do
      context 'when the enemy exists' do
        let(:enemy) { create(:enemy) }
        before(:each) { delete "/enemies/#{enemy.id}" }

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end

        it 'destroy the record' do
          expect { enemy.reload }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context 'when the enemy does not exist' do
        before(:each) { delete '/enemies/0' }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Enemy/)
        end
      end
    end
  end
end
