require "test_helper"
require "generators/solder/stimulus/stimulus_generator"

module Solder
  class Solder::StimulusGeneratorTest < Rails::Generators::TestCase
    tests Solder::StimulusGenerator
    destination Rails.root.join("tmp/generators")
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
