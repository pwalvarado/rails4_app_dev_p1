class Pin < ActiveRecord::Base
  belongs_to :board
  before_create :default_name

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :image, ImageUploader
  paginates_per 10

  def default_name
    self.name ||= File.basename(image.filename, '.*').titleize if image
  end

#https://github.com/tors/jquery-fileupload-rails, paperclip example.
#https://github.com/blueimp/jQuery-File-Upload/wiki V6 example
#https://blueimp.github.io/jQuery-File-Upload/
#http://stackoverflow.com/questions/21411988/rails-4-multiple-image-or-file-upload-using-carrierwave

end
