module Spree
  class Instruction < Spree::Base

    acts_as_list scope: :recipe
    
    belongs_to :recipe
    
    self.whitelisted_ransackable_attributes =  %w[description]
  end
end
