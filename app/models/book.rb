class Book < ApplicationRecord
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def self.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_days_ago, ->(n) { where(created_at: n.days.ago.all_day) }
  def self.past_week_count
    (0..6).map { |n| created_days_ago(n).count }.reverse
  end
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }




end
