module Spree
  class Recipe < Spree::Base

    extend FriendlyId

    validates_associated :recipe_icon

    has_one :recipe_icon, as: :viewable, dependent: :destroy, class_name: 'Spree::RecipeImage'
    has_many :recipes_taxons
    has_many :taxons, through: :recipes_taxons
    has_many :recipes_ingredients
    has_many :ingredients, through: :recipes_ingredients
    has_many :recipes_instructions
    has_many :instructions, through: :recipes_instructions

    friendly_id :name, use: :history
    before_validation :set_slug, on: :create, if: :name

    after_destroy :punch_slug
    # after_restore :update_slug_history

    before_validation :downcase_slug
    before_validation :normalize_slug, on: :update

    validates :slug, presence: true, uniqueness: { allow_blank: true, case_sensitive: true }

    self.whitelisted_ransackable_attributes =  %w[name]


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
