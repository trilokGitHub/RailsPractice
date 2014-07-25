class Article
  include Mongoid::Document
  field :name, type: String
  field :content, type: String
  field :created_by, type: String
  field :time, type: DateTime

  validates_presence_of :name
  validates_presence_of :content

  has_many :comments

  after_create :increment_article_count
  after_destroy :decrement_article_count

  @@count = 0
  def increment_article_count
    @@count = @@count+1
  end

  def decrement_article_count
    @@count = @@count-1
  end

  def floor(time, seconds)
    Time.at((time / seconds).floor * seconds)
  end

  def get_analysis_data(endTime,minute,interval)
    start_time = endTime - (minute*60)
    interval_sec = interval*60
    start_time = floor(start_time.to_i, interval_sec)

    data = Hash.new(0)
    for comment in self.comments
      if comment.time >= start_time &&  comment.time <= endTime
        add_time = (comment.time.to_i - start_time.to_i)/interval_sec
        x = start_time.to_i + add_time*interval_sec
        data[(floor(x, interval_sec)).strftime("%m/%d/%Y at %I:%M %p")  ] += 1
      elsif comment.time > endTime
        break
      end
    end


    pp "*******************DDDDDDDDDDDDDDDDDDDDDDDDDDDDDD************************* #{data}"
   data
  end

end