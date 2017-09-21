class ProjectSerializer < ActiveModel::Serializer
  attributes :permalink, :name, :description, :north, :south, :east, :west
end
