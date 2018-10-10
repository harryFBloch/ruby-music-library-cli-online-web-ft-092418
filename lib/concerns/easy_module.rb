module EasyModule
  module ClassMethods
    
    def destroy_all
      self.all.clear 
    end
    
    def create(name)
      new = self.new(name)
      new.save
      new
    end
  end
  
  module InstanceMethods
    def initialize(name)
      self.name = name
      self.songs = []
    end
    
    def save
      self.class.all << self
    end
    
    
  end
end