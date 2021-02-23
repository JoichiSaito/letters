class Request < ApplicationRecord
  belongs_to :refollowing, class_name: 'User'
  belongs_to :refollower, class_name: 'User'
end
