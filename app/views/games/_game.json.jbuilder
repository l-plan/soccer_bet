json.extract! game, :id, :nr, :date, :home_id, :away_id, :score_home, :score_away, :created_at, :updated_at
json.url game_url(game, format: :json)
