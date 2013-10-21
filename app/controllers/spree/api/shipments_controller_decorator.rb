module Spree
  module Api
    ShipmentsController.class_eval do
      prepend_view_path File.expand_path("../../../../app/views", File.dirname(__FILE__))
    end
  end
end
