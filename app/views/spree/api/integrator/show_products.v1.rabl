object false

child(@products => :products) do
  attributes *product_attributes

  child(:variants => :variants) do
    attributes *variant_attributes
  end
end

node(:count) { @products.count }
node(:current_page) { @page }
node(:pages) { @products.num_pages }
