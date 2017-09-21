# A project represents an area where tasks need to be performed.
class Project < ApplicationRecord
  validates :north, :south, :east, :west, presence: true, numericality: true
  validates :name, presence: true, length: { minimum: 4, maximum: 50 }
  validates :permalink, uniqueness: true, if: :has_permalink?

  before_validation :set_permalink

  # Like Project.find, except using permalinks instead of ids.
  def self.lookup(permalink)
    find_by(permalink: permalink)
  end

  # Ensure that serialization of projects into URLs uses the permalink
  # instead of database ids.
  def to_param
    permalink
  end

  def has_permalink?
    permalink.present?
  end

  private

  # If the permalink doesn't already exist, make one up based on the
  # name.
  def set_permalink
    return if permalink.present?

    self.permalink = name.parameterize
  end
end
