class AuguryEnvironment < ActiveRecord::Base
  attr_accessible :store_id, :token, :environment, :user, :url, :store_name
end
