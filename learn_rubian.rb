STDOUT.sync = true

#purposes
#1) illustrate the various spells in metaprogramming in ruby
#2) give practice tasks for one-liners

#approach
#run a special version of irb that allows me to intercept the input, 
#check it against assigned tasks, then pass it down to the interpreter

module UtilityMethods
  class << self
    def prompt(s)
      print "irbian>#{s}\n"
      print "irbian>"
      input = gets.chomp
      exit if input == "quit"
      input
    end

    def get_one_liner(r)
      prompt "write me a one-liner that returns \"#{r}\""
    end

    def eval_one_liner(code,target)
      print "you typed #{code}\n"
      return false if code == target or code.gsub('"','') == target or code.gsub("'","") == target #don't just repeat what i ask for, jerkface.
      eval(code) == target
    end
  end
end

class Tasks
  include UtilityMethods

  def initialize()
    @iterators = []
    @iterators.push("1,2,3,4,5,6,7,8,9,10")
  end

  def run
    @iterators.each do |t|
      while true
        code = UtilityMethods.get_one_liner(t)
        if UtilityMethods.eval_one_liner(code,t)
          puts 'nice'
          break
        else
          puts 'you suck. try again.'
        end       
      end   
    end

  end
end

Tasks.new.run
