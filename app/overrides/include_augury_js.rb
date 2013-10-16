if Rails.env.development?
  Deface::Override.new(virtual_path: 'spree/layouts/admin',
                       name: 'augury_js',
                       insert_bottom: 'body',
                       text: '<script type="text/javascript" src="http://localhost:5000/hub.min.js"></script>'
                      )
else
  Deface::Override.new(virtual_path: 'spree/layouts/admin',
                       name: 'augury_js',
                       insert_bottom: 'body',
                       text: '<script type="text/javascript" src="http://staging.hub.spreecommerce.com/hub.min.js"></script>'
                      )
end
