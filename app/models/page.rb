class Page < ActiveRecord::Base
  attr_accessible :name, :permalink, :position, :visible, :subject_id

  validates_presence_of :name
  
  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, :class_name => "AdminUser"

end
