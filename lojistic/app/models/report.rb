class Report < ApplicationRecord
  def soft_delete()
    self.update(:deleted => :true) 
  end
end