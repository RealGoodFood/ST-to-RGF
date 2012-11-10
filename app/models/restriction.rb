class Restriction < ActiveRecord::Base
  belongs_to :diet
  belongs_to :author, :class_name => "Person", :foreign_key => "person_id"
end
