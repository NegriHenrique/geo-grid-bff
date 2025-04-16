if Rails.env.development?
  Rails.application.config.after_initialize do
    require_dependency Rails.root.join("app", "jobs", "generate_game_job.rb")
    GenerateGameJob.perform_later
  end
end
