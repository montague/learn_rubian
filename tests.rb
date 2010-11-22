module Learn_Rubian
  class Tests
    class << self
      def show_methods(o)
        o.methods.select {|m| o.method(m).to_s[Regexp.new(": #{o.class}\#")]}
      end
    end
  end
end
