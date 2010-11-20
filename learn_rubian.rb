STDOUT.sync = true

#purposes
#1) illustrate the various spells in metaprogramming in ruby
#2) give practice tasks for one-liners

#approach
#run a special version of irb that allows me to intercept the input, 
#check it against assigned tasks, then pass it down to the interpreter

module UtilityMethods
  class << self
   
    
    def init
      @commands = {"quit" => :exit, "skip" => :break, "fuck" => "watch your language."}
      @last_entered =  []
      @buffer = ""
    end
    def prompt(s)
      print "irbian> #{s}\n"
      print "irbian> #{@buffer}"
      @buffer = ""
      input = gets.chomp
      input
    end

    def run(tasks)
      init
      tasks.each do |task|

        while true #run eval loop
        code = get_one_liner(task)
          case code
            when "quit" 
              exit
            when "skip" 
              print "on to the next one...\n"
            break
            when "p"
              @buffer = @last_entered.pop
          else
            if eval_one_liner(code,task)
               puts 'nice'
               break
             else
               puts 'nah. try again.'
              code = get_one_liner(task)
            end
          end       
        end   
      end
    end

    def handle_input(input,task)
      if @commands.keys.include?(input)
        
      else
        eval_one_liner(input,task)
      end
    end

    def get_one_liner(r)
      prompt "write me a one-liner that returns \"#{r}\""
    end

    def eval_one_liner(code,target)
      @last_entered.push(code)
      print "you typed #{code}\n"
      #don't just repeat what i ask for, jerkface.
      if code == target or code.gsub('"','') == target or code.gsub("'","") == target 
        print "nice try, smartass...\n"
        return false
      end
      begin
        eval(code) == target
      rescue Exception
        print "not sure what that was, but it wasn't valid code.\n"
        false
      end
    end
  end
end

class Tasks
  include UtilityMethods
  
  class << self
    #set up array of one-liners to ask for
    def initialize()
      @t = [
            "1,2,3,4,5,6,7,8,9,10",
             "[2,4,6,8]",
             "[1,1,1,1]"
           ]
    end
    
    

    def run
      initialize()
      UtilityMethods.run(@t)
#      @t.each do |t|
 #       while true
  #        code = UtilityMethods.get_one_liner(t)
   #       if UtilityMethods.eval_one_liner(code,t)
    #        puts 'nice'
     #       break
      #    else
       #     puts 'nah. try again.'
        #  end       
       # end   
    #  end
    end
  end
end

Tasks.run
