# A Task represents an action that should be taken within a project.
#
# Tasks *may* have an assigned location. If they do, that location
# indicates where the task needs to be performed. If they do not, the
# task is considered project-wide.
class Task < ApplicationRecord
  belongs_to :project, inverse_of: :tasks
  
  validates :lat, numericality: { allow_nil: true, less_than: 90.0, greater_than: -90.0 }
  validates :lon, numericality: { allow_nil: true, less_than: 180.0, greater_than: -180.0 }
  validates :name, presence: true, length: { minimum: 4, maximum: 50 }

  # Need to ensure that lat and lon are both provided, or that neither
  # are provided.
  validates :lat, presence: { if: -> { lon.present? } }
  validates :lon, presence: { if: -> { lat.present? } }
  
  validates :name, presence: true

  validate :located_within_project

  scope :complete, -> { where complete: true }
  scope :incomplete, -> { where complete: false }

  # Does this task have a location, or is it available anywhere?
  def has_location?
    # Since we require presence of both lat&lon, checking for one
    # property is good enough.
    lat.present?
  end

  private

  def located_within_project
    # Don't explode on edge cases wehre the project isn't present
    return if project.blank?
    
    errors.add(:base, :outside_project) unless project.contains?(self)
  end
end
