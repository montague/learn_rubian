STDOUT.sync = true

#purposes
#1) illustrate the various spells in metaprogramming in ruby
#2) give practice tasks for one-liners

#approach
#run a special version of irb that allows me to intercept the input, 
#check it against assigned tasks, then pass it down to the interpreter

module Iterators
  def self.t_range
    
    puts 'write me a one-liner that returns "1,2,3,4,5,6,7,8,9,10".'
    code = prompt
    puts eval(code)
  end
end

def prompt
  print "irbian>"
  gets.chomp
end

def get_one_liner(r)
  "write me a one-liner that returns \"#{r}\""
  prompt
end

s = nil

# until s == 'q'
#   Iterators.t_range
# end
puts 'good-bye'
