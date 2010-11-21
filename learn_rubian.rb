
STDOUT.sync = true

#purposes
#1) illustrate the various spells in metaprogramming in ruby
#2) give practice tasks for one-liners

#approach
#run a special version of irb that allows me to intercept the input, 
#check it against assigned tasks, then pass it down to the interpreter
#this is pretty much out the window at this point... who knows where this will go.
module Util
  class << self
    PROMPT = "irbian>"
    
    def init
      @commands = {"quit" => :exit, "skip" => :skip, "fuck" => [:display_message,"watch your language."]}
      @skip = false
    end
    
    def skip
      @skip = true
      display_message("on to the next one...")
    end

    def display_message(s)
      print "#{PROMPT} #{s}\n"
    end

#    def display_prompt(s)
#      print "#{PROMPT} #{s}\n"
#      print "#{PROMPT} " 
#    end
    
    def display_task_prompt(task)
      display_message("write a one-liner that outputs #{task}")
      print "#{PROMPT} "
    end

    def process_input(input)
      if @commands.keys.include?(input)
        execute_command(input)
      else
        evaluate_input(input)
      end
    end
    
    def evaluate_input(input)
      if is_a_cheater?(input)
        display_message("weak. try writing code instead of being a parrot.")
      else
        #if using a block, great.
        is_using_a_block = input[/\{.*\}|do.*end/]
        result = nil
        begin
          result = eval(input)
          is_correct = result == eval(@current_task)
        rescue Exception
          display_message("not sure what that was, but it wasn't ruby.")
          return
        end
        if is_correct 
         process_correct_input(is_using_a_block)
        else
          display_message("you coded: |#{result}|. try again.")
        end
      end
    end

    def process_correct_input(is_using_a_block)
      if is_using_a_block
         @is_current_task_complete = true 
         display_message("nice.")
       else
         display_message("good. try using a block.")
       end
    end

    def is_a_cheater?(input)
      input.gsub('"','').gsub("'","") == @current_task 
    end

    def execute_command(command)
      if @commands[command].class == Array
        self.send(*@commands[command])
      else
        self.send(@commands[command])
      end
    end
    
    def run(tasks)
      init
      tasks.each do |task|
        @current_task = task
        @is_current_task_complete = false
        while true #run eval loop
          display_task_prompt(task)
          process_input(gets.chomp)
          if @skip
            @skip = false
            break
          end
          break if @is_current_task_complete          
        end   
      end
      display_message("well done. go outside and play.")
    end
  end
end

class Tasks
  include Util
  
  class << self
    #set up array of one-liners to ask for
    def initialize()
      @t = [
            '[1, 2]',
            '"1,2,3,4,5,6,7,8,9,10"',
             '[2, 4, 6, 8]',
             '[1, 1, 1, 1]'
           ]
    end

    def go
      initialize()
      Util.run(@t)
    end
  end
end

Tasks.go
