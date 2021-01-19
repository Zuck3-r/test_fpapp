class Skill < ApplicationRecord
	has_many :planner_skills
#	belongs_to :planner, optional: true
	has_many :planners, through: :planner_skills
end
