require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  @lists = List.all()
  @tasks = Task.all
  erb(:index)
end

post('/') do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  @lists = List.all()
  erb(:layout)
end


post("/lists") do
  name = params.fetch("name")
  list = List.new(name: name, id: nil)
  list.save()
  @lists = List.all()
  @tasks = Task.all
  erb(:index)
end


get("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

get("/lists/:id/edit") do
  @list = List.find(params.fetch("id").to_i)
  erb(:list_edit)
end

patch("/lists/:id") do
  name = params.fetch("name")
  @list = List.find(params.fetch("id").to_i)
  @list.update({:name => name})
  erb(:list)
end

delete("/lists/:id") do
  @list = List.find(params.fetch("id").to_i)
  @list.delete()
  @list = List.all()
  erb(:index)
end

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  task = Task.new(description: description, id: nil, list_id: list_id)
  task.save
  @list = List.find(list_id)
  erb(:list)
end

get("/lists/:id/edit") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list_edit)
end

patch 'lists/id' do
  @task = Task.find(params.fetch('id').to_i)
  @task.update(description: params.fetch('description'))
  @tasks = Task.all
  erb(:index)
end
