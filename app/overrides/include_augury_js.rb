hub_javascript_url = ENV['HUB_JS_URL'] || "//staging.hub.spreecommerce.com/hub.min.js"

Deface::Override.new(virtual_path: 'spree/layouts/admin',
                     name: 'augury_js',
                     insert_bottom: 'body',
                     text: "<script type='text/javascript' src='#{hub_javascript_url}'></script>"
                    )
