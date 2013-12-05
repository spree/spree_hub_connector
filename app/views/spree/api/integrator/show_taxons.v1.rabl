object false

child(@taxons => :taxons) do
  attributes *taxon_attributes
end

node(:count) { @taxons.count }
node(:current_page) { @page }
node(:pages) { @taxons.num_pages }
