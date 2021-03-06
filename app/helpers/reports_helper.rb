module ReportsHelper

    def find_first_name
        if current_user.spotify_username.present?
            current_user.spotify_username.split.first
        elsif current_user.username.present?
            current_user.username
        else
            current_user.spotify_uid
        end
    end

    def find_username
        if current_user.username.present?
            current_user.username
        elsif current_user.spotify_username.present?
            current_user.spotify_username.split.first
        else
            current_user.spotify_uid
        end
    end

    def find_song_by_title(title)
        Song.find_by(title: title)
    end

    def find_album_by_title(title)
        Album.find_by(title: title)
    end

    def find_artist_by_name(name)
        Artist.find_by(name: name)
    end

    def list_external_urls(list)
        safe_join(list.map { |l| link_to(l.name, external_url(l), target: :_blank) }, ", ".html_safe)
    end

    def format_time(time)
        hours = time.to_f / (1000 * 60 * 60) #(ms * sec/min * min/hr)
        minutes = (hours - hours.floor) * 60
        hours.floor == 0 ? "#{minutes.floor}m" : "#{hours.round}h, #{minutes.floor}m"
    end

    def external_url(object)
        type = object.class.name.downcase
        type = "track" if type == "song"

        "https://open.spotify.com/" + type + "/" + object.spotify_id
    end

end
