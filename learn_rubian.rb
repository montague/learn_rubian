#!/usr/bin/env ruby
require 'readline'
#purposes
#1) illustrate the various spells in metaprogramming in ruby
#2) give practice tasks for one-liners

#approach
#run a special version of irb that allows me to intercept the input, 
#check it against assigned tasks, then pass it down to the interpreter
#this is pretty much out the window at this point... who knows where this will go.
module Learn_Rubian
  module Util
    class << self
      PROMPT = "irbian>"
      
      def init
        STDOUT.sync = true
        @commands = {"quit" => :exit, "skip" => :skip, "fuck" => [:display_message,"watch your language."]}
        @skip = false
      end
      
      def skip
        @skip = true
        display_message("on to the next one...")
      end
      
      def get_input
        line = Readline::readline("#{PROMPT} ",true)
        return nil if line.nil?
        if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
          Readline::HISTORY.pop
        end
        line
      end


      def display_message(s)
        print "#{PROMPT} #{s}\n"
      end
      
      def display_task_prompt(task)
        display_message("write a one-liner that outputs #{task.task_result}")
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
            is_correct = result == eval(@current_task.task_result)
          rescue Exception
            #display_message("not sure what that was, but it wasn't ruby.")
            display_message($!)
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
        if is_using_a_block #maybe we don't need to force a block...
          @current_task.completed = true
          display_message("nice.")
        else
          display_message("good. try using a block.")
        end
      end
      
      def is_a_cheater?(input)
        return false if input.nil?
        input.gsub(/['"]/,'') == @current_task.task_result 
      end
      
      def execute_command(command)
        if @commands[command].class == Array
          self.send(*@commands[command])
        else
          self.send(@commands[command])
        end
      end
      
      def run(tasks)
        init()
        tasks.each do |task|
          @current_task = task
          while true #run eval loop
            display_task_prompt(task)
            process_input(get_input)
            if @skip
              @skip = false
              break
            end
            break if @current_task.completed?          
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

  class Task
    DEFAULT_FAIL = "try again."
    DEFAULT_SUCCESS = "good job."
    attr_accessor :task_result, :fail_message, :success_message
    
    def completed?
      @completed
    end
    
    def completed=(s)
      @completed = s
    end
    
    def initialize(task_result, fail_message=DEFAULT_FAIL, success_message=DEFAULT_SUCCESS)
      @task_result = task_result
      @fail_message = fail_message
      @success_message = success_message
      @completed = false
    end
  end
end


