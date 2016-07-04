class User < ActiveRecord::Base
  serialize :resources_ids,Array
end
