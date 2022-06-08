require 'roo'
class Word < ActiveRecord::Base
  has_many    :user_words
  belongs_to  :lesson
  belongs_to  :course
  validates :en_word, presence: true, uniqueness: true
  validates :vi_word, presence: true
  scope :oder_by_name_word, -> { order(id: :ASC) }
  class << self
    def import_file file
    # file có thể ở dạng file hoặc là path của file đều được xử lý chính xác bởi method open
      spreadsheet = Roo::Spreadsheet.open file
      # lấy cột header (column name)
      header = spreadsheet.row 1
      (2..spreadsheet.last_row).each do |i|
        # lấy ra bản ghi và biến đổi thành hash để có thể tạo record tương ứng
        row = [header, spreadsheet.row(i)].transpose.to_h
        create! row
      end
    end
  end
end
