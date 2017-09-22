class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :complete, :created_at, :lat, :lon, :has_location

  def has_location
    object.has_location?
  end
end
