class Comment
  include Mongoid::Document
  field :name, type: String
  field :content, type: String
  field :created_by, type: String
  field :time, type: DateTime

  validates_presence_of :name
  validates_presence_of :content

  belongs_to :article

  after_create :increment_comment_count
  after_destroy :decrement_comment_count

  @@count = 0
  def increment_comment_count
    @@count = @@count+1
  end

  def decrement_comment_count
    @@count = @@count-1
  end

end
