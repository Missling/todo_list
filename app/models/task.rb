class Task < ActiveRecord::Base
  validates :priority, :inclusion => { :in => 1..5, :message => "Priority must be between 1 and 5"}
end
