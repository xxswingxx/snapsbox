class Button < ActiveRecord::Base
  paginates_per 4
  
  has_many :comments
  mount_uploader :screenshot, ScreenshotUploader

  # Associations
  belongs_to :team
  belongs_to :user
    
  after_create :get_screenshot
  after_create :create_first_comment, if: Proc.new { self.description.present? }
  
  #Validations
  validates :title, presence: true
  validates :url, presence: true
  validates_format_of :url, :with => URI::regexp(%w(http https))

  private
  def get_screenshot
    get_screenshot_task
  end

  def get_screenshot_task
    begin
      file = Tempfile.new(["#{id}_#{Time.now.to_i}".downcase, '.jpg'], 'tmp', :encoding => 'ascii-8bit')
      image = IMGKit.new(url, quality: 80).to_jpg
      file.write(image)
      file.flush
      self.screenshot = file
    rescue IMGKit::CommandFailedError
      # ERROR, NO SE PUDO GENERAR CAPTURA DE PANTALLA
    end
    self.save
    file.unlink
  end
  
  def create_first_comment
    self.comments.create(body: description, user: user )
  end
end
