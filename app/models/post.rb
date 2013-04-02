require 'uuid'

class Post < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :category
  before_create :access_keyify

  def access_keyify
    self.access_key = UUID.new.generate
  end

end
