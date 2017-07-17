class List < ActiveRecord::Base
  
  define_method(:tasks) do
    list_tasks = []
    tasks = Task.all
    tasks.each() do |task|
      description = task.description
      list_id = task.list_id
      list_tasks.push(Task.new({:description => description, :list_id => list_id}))
    end
    list_tasks
  end

end
