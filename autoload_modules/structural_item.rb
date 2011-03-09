module StructuralItem
  
  module Controller
    def get_polymorhic_parent_from_params
      params.each do |key, value|
        if key =~ /(.+)_id$/
          return @polymorphic_parent_object = $1.classify.constantize.find_by_id(value)
        end
      end
      nil
    end
  end
  

  
  module Model
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def holder (resource_symbol)
         @holder_resource_symbol = resource_symbol
      end
    end
    
    def holder
      resource_symbol = self.class.instance_variable_get(:@holder_resource_symbol)
      send(resource_symbol) if resource_symbol
    end
    
    def root_holder
      h = self.holder
      return self unless h
      h.root_holder
    end
    
    def holder_chain (chain = [])
      chain.unshift(self)
      h = self.holder
      chain = self.holder.holder_chain(chain) if h
      chain
    end
    
  end
  
end