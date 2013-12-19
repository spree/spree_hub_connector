object false

child(@return_authorizations => :return_authorizations) do
  attributes *return_authorization_attributes

  child :inventory_units => :inventory_units do
    attributes *inventory_unit_attributes

    child :variant => :variant do
      attributes *variant_attributes
    end
  end

  child :order => :order do
    extends('spree/api/orders/show')
  end   
end

node(:count) { @return_authorizations.count }
node(:current_page) { @page }
node(:pages) { @return_authorizations.num_pages }
