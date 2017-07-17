class CreateLists < ActiveRecord::Migration[5.1]
  def change
  	create_table(:lists) do |t|
  		t.column(:name, :string)
  		t.timestamps()
  	end
  	add_column(:tasks, :list_id, :integer)
  end
end
