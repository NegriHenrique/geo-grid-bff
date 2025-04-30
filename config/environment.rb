# Load the Rails application.
require_relative "application"

# Forçar o carregamento do arquivo .env
require "dotenv"
Dotenv.load

# Initialize the Rails application.
Rails.application.initialize!

# Verificar se o SECRET_KEY_BASE está sendo carregado
puts "SECRET_KEY_BASE: #{ENV['SECRET_KEY_BASE']}"
