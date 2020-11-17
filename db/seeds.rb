user = User.create(name: "Spotifier", password: "Secret")
report = user.reports.create(name: "Nov 2019 - Nov 2020")

artist = Artist.create(name: "Amazing Singer")
genre = Genre.create(name: "Very Unique")
album = Album.create(title: "The Original!")

album.songs.create(title: "Best Song Ever", reports: [report], genres: [genre], artists: [artist])