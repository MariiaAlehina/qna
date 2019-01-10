class Question < ActiveRecord::Base
  validates :title, :body, presence: true

  has_many :answers

  has_many :comments, as: :commentable
  has_many :attachments, as: :attachmentable

  belongs_to :user

  accepts_nested_attributes_for :attachments

  after_create :update_reputation

  private

  def update_reputation
    CalculateReputationJob.perform_later(self)
  end
end
