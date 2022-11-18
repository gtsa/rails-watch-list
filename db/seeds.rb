require 'open-uri'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

container = []
URI.open("https://tmdb.lewagon.com/movie/top_rated") {|f|
  f.each_line {|line| container << line}
}

# p container

require 'json'
json_response =[]

container.each {|j| json_response << JSON.parse(j)}

json_response[0]['results'].each do |movie|
  entry = Movie.new
  entry.title = movie['original_title']
  entry.overview = movie['overview']
  entry.rating = movie['vote_average']
  entry.poster_url = 'https://www.themoviedb.org/t/p/w600_and_h900_bestv2'+movie['poster_path']
  entry.save
end
