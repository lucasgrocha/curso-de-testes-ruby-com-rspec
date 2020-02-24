class Weapon < ApplicationRecord

  validates :power_base, presence: true
  validates :power_step, presence: true
  validates :level, presence: true

  def current_power
    (self.power_base + ((self.level - 1) * self.power_step))
  end

  def title
    "#{self.name} ##{self.level}"
  end
end
