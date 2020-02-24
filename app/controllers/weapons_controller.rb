class WeaponsController < ApplicationController
  def index
    @weapons = Weapon.all
  end

  def create
    Weapon.create(weapon_params)
  end

  def destroy
    Weapon.find(weapon_id).destroy
  end

  def show
    @weapon = Weapon.find(weapon_id)
  end

  private

  def weapon_id
    params.permit(:id)[:id]
  end

  def weapon_params
    params.require(:weapon).permit(:name, :description, :power_base, :power_step, :level)
  end
end
