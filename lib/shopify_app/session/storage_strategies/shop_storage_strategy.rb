module ShopifyApp
  module SessionStorage
    module ShopStorageStrategy
      def store(auth_session, *args)
        shop = find_or_initialize_by(shopify_domain: auth_session.domain)
        shop.shopify_token = auth_session.token
        shop.save!
        shop.id
      end

      def retrieve(id)
        return unless id
        if shop = self.find_by(id: id)
          ShopifyAPI::Session.new(
            domain: shop.shopify_domain,
            token: shop.shopify_token,
            api_version: shop.api_version
          )
        end
      end
    end
  end
end
