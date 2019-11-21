class Character < ApplicationRecord
  has_many :skills, dependent: :destroy

  scope :name, -> (name) {where("name LIKES %", name,"%")}
  puts name

  def life
    10 + (constitution-10)/2
  end

  def level
      (strength +
      dexterity +
      constitution +
      intelligence +
      wisdom +
      charisma)/6.round
  end

  def proficient
     value = 2

     if((5..8).include?(level))
       value += 1
     elsif (9..12).include?(level)
       value += 2
     elsif (13..16).include?(level)
       value += 3
     elsif (17..20).include?(level)
       value += 4
     end

     value
  end





end
