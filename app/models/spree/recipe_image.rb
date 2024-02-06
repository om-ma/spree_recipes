module Spree
  class RecipeImage < Asset
    include Configuration::ActiveStorage
    include Rails.application.routes.url_helpers
    include ::Spree::ImageMethods

    def styles
      self.class.styles.map do |_, size|
        width, height = size[/(\d+)x(\d+)/].split('x')

        {
          url: polymorphic_path(attachment.variant(resize: size), only_path: true),
          width: width,
          height: height
        }
      end
    end

    def my_cf_image_url(style)
      
      default_options = Rails.application.default_url_options
      ActiveStorage::Current.host = default_options[:host]
      str = self.url(style).blob.url
      path = str.split('//').last.split("/",2).last
      Rails.env.development? ? str : "https://#{ENV['CLOUDFRONT_ASSET_URL']}/#{path}"
    end
    
  end
end
