# frozen_string_literal: true

##
# ApplicationRecord class
#
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def destroy
    update_attribute(:deleted, 1)
  end

  def self.deleted
    where('deleted = 1')
  end

  def self.find_all
    where('deleted = 0')
  end
end
