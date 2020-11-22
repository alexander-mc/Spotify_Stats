user = User.find_or_create_by(username: "Spotifier")
report = user.reports.find_or_create_by(report_name: "Nov 2019 - Nov 2020", attachment: 'test.json')

# artist = Artist.find_or_create_by(name: "Amazing Singer")
# genre = Genre.find_or_create_by(name: "Very Unique")

# album = Album.find_or_create_by(title: "The Original!")
# album.songs.find_or_create_by(title: "Best Song Ever", reports: [report], genres: [genre], artists: [artist])