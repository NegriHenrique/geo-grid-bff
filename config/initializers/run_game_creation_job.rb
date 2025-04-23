# Ajuste para garantir que o job seja executado apenas após as migrações
Rails.application.config.after_initialize do
  if ActiveRecord::Base.connection.table_exists?("solid_queue_jobs")
    require_dependency Rails.root.join("app", "jobs", "generate_game_job.rb")
    GenerateGameJob.perform_later
  else
    Rails.logger.warn("Tabela 'solid_queue_jobs' não encontrada. O job não foi enfileirado.")
  end
end
