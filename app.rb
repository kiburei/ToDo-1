require('sinatra')
require('sinatra/reloader')
require('./lib/todo')
require('./lib/list')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "to_do"})


get("/") do
    @list = list.all()
  erb(:index)
end

post("/lists") do
    name = params.fetch("name")
    list = list.new({:name => name, :id => nil})
    list.save()
    @lists = list.all()
  erb(:index)
end


get("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:task_success)
end

get("/lists/:id/edit") do
    @list = List.find(params.fetch("id").to_i())
    erb(:list_edit)
end

