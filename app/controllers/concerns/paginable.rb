# frozen_string_literal: true

require "pagy/extras/countless"

module Paginable
  extend ActiveSupport::Concern

  # The default page size for paginated resources.
  PAGE_SIZE = 20

  included do
    include Pagy::Backend

    # Perform infinite scroll pagination on a collection of resources.
    #
    # This method uses the Pagy gem to paginate a collection of resources for
    # infinite scroll pagination. It returns a paginated subset of the
    # resources along with pagination metadata.
    # Aditionally sets the @pagination instance variable with the pagination metadata.
    #
    # @param resources [ActiveRecord::Relation] The collection of resources to paginate.
    # @param page_size [Integer] The number of items to include on each page.
    #   Defaults to `PAGE_SIZE` if not provided.
    #
    # @return [ActiveRecord::Relation] a paginated subset of the resources

    def infinite_scroll_pagination(resources, page_size: PAGE_SIZE)
      @pagination, paginated_resources = pagy_countless(
        resources, items: page_size
      )

      paginated_resources
    end
  end
end
