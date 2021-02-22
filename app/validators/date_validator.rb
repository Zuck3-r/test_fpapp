class DateValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		if value <= Date.today
			record.errors.add(attribute, "過去には戻れ無いよ")
		elsif value.sunday?
			record.errors.add(attribute, "日曜日は仕事しないで！！")
		end
	end
end
