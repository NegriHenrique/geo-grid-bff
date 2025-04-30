# Forçar o carregamento do arquivo .env
require "dotenv"
Dotenv.load

# Load the Rails application.
require_relative "application"

# Certifique-se de que as variáveis de ambiente estão configuradas corretamente
ENV["RAILS_ENV"] ||= "production"
ENV["SECRET_KEY_BASE"] ||= "32a2c98947c3645a3d4a7f4ffa718d58ef0d64747a998d66887feba3d2557bc63a6880a076823c11e2551ea55bbd9b28aa95b3670d6796602246e226bf459873"
ENV["RAILS_MASTER_KEY"] ||= "67ff169372fe299b748b064d35714faf"

# Initialize the Rails application.
Rails.application.initialize!
