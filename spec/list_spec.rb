
require("spec_helper")

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

describe(List) do
  describe(".all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list.name()).to(eq("Epicodus stuff"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end

  it("deletes a list's tasks from the database") do
    list = List.new({:name => "Moringa School stuff", :id => nil})
    list.save()
    task = Task.new({:description => "learn SQL", :list_id => list.id()})
    task.save()
    task2 = Task.new({:description => "Review Ruby", :list_id => list.id()})
    task2.save()
    list.delete()
    expect(Task.all()).to(eq([]))
  end
end

describe("#==") do
  it("is the same list if it has the same name") do
    list1 = List.new({:name => "Epicodus stuff", :id => nil})
    list2 = List.new({:name => "Epicodus stuff", :id => nil})
    expect(list1).to(eq(list2))
  end
end

describe(".find") do
  it("returns a list by its ID") do
    test_list = List.new({:name => "Moringaschool stuff", :id => nil})
    test_list.save()
    test_list2 = List.new({:name => "Home stuff", :id => nil})
    test_list2.save()
    expect(List.find(test_list2.id())).to(eq(test_list2))
  end
end

describe("#tasks") do
  it("returns an array of tasks for that list") do
    test_list = List.new({:name => "Moringaschool stuff", :id => nil})
    test_list.save()
    test_task = Task.new({:description => "Learn SQL", :list_id => test_list.id()})
    test_task.save()
    test_task2 = Task.new({:description => "Review Ruby", :list_id => test_list.id()})
    test_task2.save()
    expect(test_list.tasks()).to(eq([test_task, test_task2]))
  end
end
