require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")

get("/") do
  @task = Task.all()
  erb(:index)
end

post("/task") do
  description = params.fetch("description")
  task = Task.new(description)
  task.save()
  erb(:success)
end
