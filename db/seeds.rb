# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


categories = [
  "Fiction",
  "Non-Fiction",
  "Science Fiction",
  "Fantasy",
  "Mystery",
  "Thriller",
  "Biography",
  "Memoir",
  "Self-Help",
  "Health",
  "History",
  "Travel",
  "Children's",
  "Young Adult",
  "Classics",
  "Romance",
  "Horror",
  "Science",
  "Poetry",
  "Art",
  "Cookbooks",
  "Graphic Novels",
  "Comics",
  "Education",
  "Religion",
  "Philosophy",
  "Sports",
  "Humor",
  "Drama",
  "Music",
  "Business",
  "Technology",
  "Psychology",
  "Sociology",
  "Politics",
  "Economics",
  "Law",
  "Anthology",
  "Crime"
]

categories.each do |category|
  Category.create(name: category)
end
