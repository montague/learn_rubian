module Learn_Rubian 
  module Util
    class << self
      PROMPT = "irbian>"
      
      def init
        STDOUT.sync = true
        @commands = {"quit" => :exit, "skip" => :skip, "fuck you" => [:display_message,"watch your language."]}
        @skip = false
      end
      
      def skip
        @skip = true
        #display_message("on to the next one...")
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
        @current_task.input = input
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
        msg = "nice. #{@current_task.input.size} chars to complete."
        if is_using_a_block #maybe we don't need to force a block...
          @current_task.completed_with_block = true
          # @current_task.completed = true
          display_message("#{msg} #{'try it without using a block.' unless @current_task.completed?}")
        else
          @current_task.completed_without_block = true
          display_message("#{msg} #{'try using a block.' unless @current_task.completed?}")
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
        display_message("that's it. go outside and play.")
      end
    end
  end
end
