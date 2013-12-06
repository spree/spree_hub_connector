object false

child(@return_authorizations => :return_authorizations) do
  attributes *return_authorization_attributes

  child :order => :order do
    extends('spree/api/orders/show')
  end   
end

node(:count) { @return_authorizations.count }
node(:current_page) { @page }
node(:pages) { @return_authorizations.num_pages }
