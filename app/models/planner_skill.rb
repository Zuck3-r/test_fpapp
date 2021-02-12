class PlannerSkill < ApplicationRecord
  belongs_to :planner
  belongs_to :skill
  
  validates :skill, inclusion: { in: 1..9 }
end
