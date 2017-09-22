# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p = Project.new name: "Park cleanup",
                description: "Miscellaneous cleanup and maintenance of the park",
                north: 39.908133,
                south: 39.904536,
                east:  -105.059492,
                west:  -105.063291

p.save!

p.tasks.create!  name: "Remove graffiti",
                 lat: 39.90522,
                 lon: -105.059987,
                 complete: false

p.tasks.create!  name: "Mow grass",
                 complete: false

p.tasks.create!  name: "Replace lights",
                 lat: 39.90792,
                 lon: -105.06021,
                 complete: false
  
