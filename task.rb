module Learn_Rubian
  class Task
    DEFAULT_FAIL = "try again."
    DEFAULT_SUCCESS = "good job."
    attr_accessor :task_result, :fail_message, :input
    attr_accessor :success_message
    attr_accessor :completed_with_block, :completed_without_block

    def completed?
      @completed_with_block && @completed_without_block
    end
    
    def initialize(task_result, fail_message=DEFAULT_FAIL, success_message=DEFAULT_SUCCESS)
      @task_result = task_result
      @fail_message = fail_message
      @success_message = success_message
      @completed = false
    end
  end
end
