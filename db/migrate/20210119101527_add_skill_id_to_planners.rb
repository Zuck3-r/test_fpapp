class AddSkillIdToPlanners < ActiveRecord::Migration[6.0]
  def change
    add_column :planners, :skill_id, :integer
  end
end
