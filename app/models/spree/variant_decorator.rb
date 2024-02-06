module Spree
  module VariantDecorator

    def self.prepended(base)
      base.has_many :ingredients
    end

  end
end
::Spree::Variant.prepend(Spree::VariantDecorator)
