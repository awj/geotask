class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_initialize :setup_record

  private

  def setup_record
    # Nothing to do by default
  end
end
