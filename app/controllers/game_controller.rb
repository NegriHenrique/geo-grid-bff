class GameController < ApplicationController
  def new
    game = Game.last

    if game.nil?
      render json: { error: "No game found" }, status: :not_found
      return
    end

    render json: game.to_json
  end
end
