STDOUT.sync = true

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

until s == 'q'
  Iterators.t_range
end
puts 'good-bye'
