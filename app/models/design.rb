# == Schema Information
#
# Table name: designs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  html       :text
#  css        :text
#  created_at :datetime
#  updated_at :datetime
#

class Design < ActiveRecord::Base


  def update_code(column, code)
    self.update_column(column, code)
  end
end
