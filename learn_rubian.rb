#!/usr/bin/env ruby
require 'readline'

#
# All code in this project is licensed under the MIT license.
# Enjoy.
#
#purposes
#1) illustrate the various spells in metaprogramming in ruby
#2) give practice tasks for one-liners
#3) teach myself some ruby

module Learn_Rubian
  require './util.rb'
  require './task.rb'

  class Irbian
    include Util
    
    class << self
      #set up array of one-liners to ask for
      def initialize()
        @t = [
              Task.new('[1, 2]'),
              Task.new('"1,2,3,4,5,6,7,8,9,10"'),
              Task.new('[2, 4, 6, 8]'),
              Task.new('[1, 1, 1, 1]')
             ]
      end
      
      def go
        initialize()
        Util.run(@t)
      end
    end
  end
end


