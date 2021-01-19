class CreatePlannerSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :planner_skills do |t|
      t.integer :planner_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
