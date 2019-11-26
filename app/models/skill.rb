class Skill < ApplicationRecord
  belongs_to :character

  scope :find_all_by_character_id, ->(id){where('character_id = ?', "#{id}") if id.present?}

  def score
    attribute = character.read_attribute(self.ability)
    attributeModifier = ((attribute - 10) / 2)

    if(attribute && self.proficient?)
      return character.proficient + (attributeModifier)
    end
    return attributeModifier
  end



end
