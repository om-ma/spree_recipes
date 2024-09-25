module Spree
  class Recipe < Spree::Base

    extend FriendlyId

    validates_associated :recipe_icons

    has_many :recipe_icons, as: :viewable, dependent: :destroy, class_name: 'Spree::RecipeImage'
    has_many :recipes_taxons
    has_many :taxons, through: :recipes_taxons
    has_many :ingredients
    has_many :instructions
    has_many :recipe_videos

    friendly_id :name, use: :history
    before_validation :set_slug, on: :create, if: :name

    after_destroy :punch_slug
    # after_restore :update_slug_history
    validates :name, presence: true, uniqueness: true

    before_validation :downcase_slug
    before_validation :normalize_slug, on: :update

    validates :slug, presence: true, uniqueness: { allow_blank: true, case_sensitive: true }

    self.whitelisted_ransackable_attributes =  %w[name]

    def recipe_image
      recipe_icons.first if recipe_icons.present?
    end

    def recipe_image_tag
      recipe_image.my_cf_image_url(:plp) if recipe_image.present?
    end

    def recipe_attachment
      recipe_image.try(:attachment)
    end

    accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: ->(pp) { pp[:name].blank? }
    accepts_nested_attributes_for :instructions, allow_destroy: true, reject_if: ->(pp) { pp[:description].blank? }


    def normalize_slug
      self.slug = normalize_friendly_id(slug)
    end

    def set_slug
      self.slug = name.to_url if slug.blank?
    end

    def punch_slug
      # punch slug with date prefix to allow reuse of original
      update_column :slug, "#{Time.current.to_i}_#{slug}"[0..254] unless frozen?
    end

    def update_slug_history
      save!
    end

    def downcase_slug
      slug&.downcase!
    end
    
  end
end
