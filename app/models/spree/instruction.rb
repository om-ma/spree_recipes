module Spree
  class Instruction < Spree::Base
    has_many :recipes_instructions
    has_many :recipes, through: :recipes_instructions
    self.whitelisted_ransackable_attributes =  %w[description]
  end
end
