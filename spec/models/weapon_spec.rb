require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it 'returns the correct weapon title' do
    name   = FFaker::Internet.user_name
    level  = FFaker::Random.rand(1..9)
    weapon = create(:weapon, name: name, level: level)

    expect(weapon.title).to eq("#{name} ##{level}")
  end

  it 'returns current weapon power' do
    power_base  = FFaker::Random.rand(1..3000)
    power_step  = FFaker::Random.rand(1..1000)
    level       = FFaker::Random.rand(1..9)
    weapon      = create(:weapon, power_base: power_base, power_step: power_step, level: level)

    expect(weapon.current_power).to be(power_base + ((level - 1) * power_step))
  end
end
