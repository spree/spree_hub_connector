object false

child(@stock_transfers => :stock_transfers) do
  attributes *stock_transfer_attributes

  child :source_location => :source_location do
    attributes :name
    extends "spree/api/addresses/show"
  end

  child :source_movements => :source_movements do
    extends "spree/api/stock_movements/show"
  end

  child :destination_location => :destination_location do
    attributes :name
    extends "spree/api/addresses/show"
  end

  child :destination_movements => :destination_movements do
    extends "spree/api/stock_movements/show"
  end
end

node(:count) { @stock_transfers.count }
node(:current_page) { @page }
node(:pages) { @stock_transfers.num_pages }
