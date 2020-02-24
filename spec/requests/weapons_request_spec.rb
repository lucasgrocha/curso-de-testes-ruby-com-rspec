require 'rails_helper'

RSpec.describe "Weapons", type: :request do

  describe "GET /weapons" do
    it 'returns success status' do
      get weapons_path
      expect(response).to have_http_status(200)
    end

    it 'verifies the weapon\'s names' do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.name)
      end
    end

    it 'verifies the weapon\'s current_power' do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.current_power.to_s)
      end
    end

    it 'verifies the weapon\'s titles' do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.title)
      end
    end

    it 'verifies the weapon\'s links' do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include("/weapons/#{weapon.id}")
      end
    end
  end

  describe 'POST /weapons' do
    context 'when has valid parameters' do
      it 'creates a weapon with correct attributes' do
        weapon_attributes = FactoryBot.attributes_for(:weapon)
        post weapons_path, params: { weapon: weapon_attributes }
        expect(Weapon.last).to have_attributes(weapon_attributes)
      end
    end

    context 'when has no valid parameters' do
      it 'does not create a weapon' do
        expect do
          post weapons_path, params: { weapon: { name: '', description: '', power_base: '', power_step: '', level: '' }}
        end.to_not change(Weapon, :count)
      end
    end
  end

  describe 'DELETE /weapons' do
    it 'verifies if the weapon get destroyed' do
      weapons = create_list(:weapon, 2)
      delete "/weapons/#{weapons[0].id}"
      expect(Weapon.all).to_not include(weapons[0])
    end
  end

  describe 'SHOW /weapons' do
    context 'when has valid parameters' do
      it 'verifies if the weapon has its attributes' do
        weapons = create_list(:weapon, 3)
        weapons.each do |weapon|
          get "/weapons/#{weapon.id}"
          expect(response.body).to include(weapon.title)
          expect(response.body).to include(weapon.name)
          expect(response.body).to include(weapon.description)
          expect(response.body).to include(weapon.power_base.to_s)
          expect(response.body).to include(weapon.power_step.to_s)
          expect(response.body).to include(weapon.level.to_s)
          expect(response.body).to include(weapon.current_power.to_s)
        end
      end
    end
  end
end
