module Learn_Rubian
  class Tests
    class << self
      #show all methods defined for an object
      def show_methods(o)
        o.methods.reject do |m|
          c = o.is_a?(Class) ? o : o.class
          c.superclass.methods.include?(m)
        end
      end
    end
  end
end
