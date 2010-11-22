module Learn_Rubian
  class Tests
    class << self
      def show_methods(o)
        o.methods.select {|m| o.method(m).receiver.to_s[Regexp.new("^#{o.to_s}$")]}
      end
    end
  end
end
