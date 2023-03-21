require "test_helper"
require "generators/solder/initializer/initializer_generator"

module Solder
  class Solder::InitializerGeneratorTest < Rails::Generators::TestCase
    tests Solder::InitializerGenerator
    destination Rails.root.join("tmp/generators")
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
