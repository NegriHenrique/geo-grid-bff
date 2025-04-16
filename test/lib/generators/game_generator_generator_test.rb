require "test_helper"
require "generators/game_generator/game_generator_generator"

class GameGeneratorGeneratorTest < Rails::Generators::TestCase
  tests GameGeneratorGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
