class Character < ApplicationRecord
  has_many :skills, dependent: :destroy

  validates :name, presence: true
  validates :strength,
            :dexterity,
            :constitution,
            :intelligence,
            :wisdom,
            :charisma,
            :inclusion => 1..20,
            numericality: { only_integer: true },
            format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." }

  scope :filter_name, ->(name){where('name LIKE ?', "%#{name}%") if name.present?}

  scope :filter_gt, ->(str_gt) {where('strength > ?', str_gt) if str_gt.present?}
  scope :filter_lt, ->(str_lt) {where('strength < ?', str_lt) if str_lt.present?}

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
