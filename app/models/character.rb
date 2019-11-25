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

  scope :filter_str_gt, ->(str_gt) {where('strength >= ?', str_gt) if str_gt.present?}
  scope :filter_str_lt, ->(str_lt) {where('strength =< ?', str_lt) if str_lt.present?}

  scope :filter_dex_gt, ->(dex_gt) {where('dexterity >= ?', dex_gt) if dex_gt.present?}
  scope :filter_dex_lt, ->(dex_lt) {where('dexterity =< ?', dex_lt) if dex_lt.present?}

  scope :filter_con_gt, ->(con_gt) {where('constitution >= ?', con_gt) if con_gt.present?}
  scope :filter_con_lt, ->(con_lt) {where('constitution =< ?', con_lt) if con_lt.present?}

  scope :filter_int_gt, ->(int_gt) {where('intelligence >= ?', int_gt) if int_gt.present?}
  scope :filter_int_lt, ->(int_lt) {where('intelligence =< ?', int_lt) if int_lt.present?}

  scope :filter_wis_gt, ->(wis_gt) {where('wisdom >= ?', wis_gt) if wis_gt.present?}
  scope :filter_wis_lt, ->(wis_lt) {where('wisdom =< ?', wis_lt) if wis_lt.present?}

  scope :filter_cha_gt, ->(cha_gt) {where('charisma >= ?', cha_gt) if cha_gt.present?}
  scope :filter_cha_lt, ->(cha_lt) {where('charisma =< ?', cha_lt) if cha_lt.present?}


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