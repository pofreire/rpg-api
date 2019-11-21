class Skill < ApplicationRecord
  belongs_to :character

  def score
    attribute = character.read_attribute(self.ability)
    attributeModifier = ((attribute - 10) / 2)

    if(attribute && self.proficient?)
      return character.proficient + (attributeModifier)
    end
    return attributeModifier
  end

end
