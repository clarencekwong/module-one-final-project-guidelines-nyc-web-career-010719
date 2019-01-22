class UpdateStudentModuleDataType < ActiveRecord::Migration[4.2]
  def change
    change_column :students, :module, :integer
  end
end
