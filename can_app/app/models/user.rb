class User < ActiveRecord::Base
  include Canable::Cans
  include Canable::Ables
  userstamps! # adds creator and updater


  # permission logic
  
  def creatable_by?(user)
    true
  end

  
  def viewable_by?(user)
    true
  end


  include Canable::Ables
  

  # permission logic
  
  def creatable_by?(user)
    true
  end

  
  def viewable_by?(user)
    true
  end


include Canable::Ables


# permission logic



end