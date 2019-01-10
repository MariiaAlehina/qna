class Answer < ApplicationRecord
  validates :body, presence: true
  belongs_to :question
  belongs_to :user

  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :attachments

  validates :body, presence: true

  after_create :update_reputation

  private

  def update_reputation
    CalculateReputationJob.perform_later(self)
  end
end
