class GenerateGameJob < ApplicationJob
   queue_as :default

  # Tenta reexecutar o job em caso de erro (até 5 vezes, com espera de 5 segundos entre cada tentativa)
  retry_on StandardError, wait: 5.seconds, attempts: 5

  def perform
    conditions = GameGenerator.generate_conditions(6)
    grid_game = GridGame.new(conditions)
    payload = grid_game.mapping

    Game.create!(payload: payload)
  rescue => e
    Rails.logger.error("Falha na geração do grid: #{e.message}")
    # Re-raise para que o mecanismo de retry do ActiveJob seja acionado
    raise e
  end
end
