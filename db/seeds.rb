# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Category.delete_all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(name: "Book", emoji: "📚", order: 1)
Category.create(name: "Music", emoji: "🎧", order: 2)
Category.create(name: "Movies/Series", emoji: "🎬", order: 3)
Category.create(name: "Podcast", emoji: "🎙", order: 4)
Category.create(name: "Games", emoji: "👾", order: 5)
Category.create(name: "Clothes", emoji: "👖", order: 6)
Category.create(name: "Beauty", emoji: "💄", order: 7)
Category.create(name: "Food", emoji: "🍔", order: 8)
Category.create(name: "Courses", emoji: "🎓", order: 9)
Category.create(name: "Electronics", emoji: "💻", order: 10)




