object false

child(@orders => :orders) do
  extends('spree/api/orders/show')
end

node(:count) { @orders.count }
node(:current_page) { @page }
node(:pages) { @orders.num_pages }
