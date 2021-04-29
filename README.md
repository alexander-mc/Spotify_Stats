# Spotify Stats

Why wait until the end of the year to view your music history on Spotify? Request your streaming history data over the past year from your Spotify account and then use Spotify Stats to interpret the data. This program displays data on your listening behavior in one clean view and stores the information so that you can review it later.

## Links

+ [Spotify Stats](https://spotifystatsapp.herokuapp.com/) - Play with the app! Note that this app works best on Chrome.
+ [Live Demo](https://youtu.be/X0c1Zpq_0Es) - Watch me demo the app

## Preview

![Welcome Screen](/public/screenshots/01_Welcome.png)
![Sign Up Screen](/public/screenshots/02_Sign_Up.png)
![Create Report Screen](/public/screenshots/03_Create.png)
![Upload File Screen](/public/screenshots/04_Upload.png)
![Report - Songs Screen](/public/screenshots/05_Report_Total.png)
![Report - Artists Screen](/public/screenshots/06_Report_Artists.png)
![Report - Albums Screen](/public/screenshots/07_Report_Albums.png)
![Report - Genres Screen](/public/screenshots/08_Report_Genres.png)

## Usage

1. Request your streaming history data. First, [log in](spotify.com/) to your Spotify account. Next, click on the 'Privacy settings' link on the left sidebar.

![Spotify Settings Screen](/public/screenshots/09_Spotify_Settings.png)

Scroll down to the bottom of the page, click on the 'Request' button to request your data, and go to your email to confirm the request.

![Spotify Request Data Screen](/public/screenshots/10_Spotify_Request.png)

Wait a couple days for an email from Spotify with a link to download your files. You will then have 14 days to download the file.

*Note: Spotify mentions that it could take up to 30 days to process your request, however I have typically received my data 2-3 business days after submitting my request (and I've requested data quite a bit).*

2. Upload the streaming history JSON file. Once you've downloaded your data from Spotify, look for the file with 'StreamingHistory' in the title.

![Spotify Data File Screen](/public/screenshots/11_Spotify_File.png)

Log in to Spotify Stats, click 'Add Report', and upload this file.

3. Create the report! In the app, click on 'Create Report', then minimize the screen and grab a cup of coffee. The program could take some time to run through all the data, so be patient -- it will be worth the wait! It took a little less than an hour for the program to process my file, which was about 50k lines of code (this came out to ~8k songs, or ~320 hours of music).

## Configuration

1. Register a Spotify application and obtain a client ID and client secret. Follow this guide from Spotify for information on how to do this: https://developer.spotify.com/documentation/general/guides/app-settings.

2. Create a file titled '.env' in the program's root directory with the following (replace the 'X's with information from the previous step):

```
export CLIENT_ID=XXXXXXXXXXXXXXXXXXXXXXX
export CLIENT_SECRET=XXXXXXXXXXXXXXXXXXX
```

3. Run 'bundle install' to install the necessary Ruby gems and you're good to go!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexander-mc/spotify-stats. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.
