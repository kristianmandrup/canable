require 'generator_helper'

class Mongoid::Generators::ModelGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Mongoid::Generators::ModelGenerator

  setup :prepare_destination
  setup :copy_routes

  def assert_model(name)
    assert_file "app/models/user.rb" do |account|
      assert_class "User", account do |klass|
        assert_match /include Canable::Cans/, klass
      end
    end
  end

  test "invoke with no arguments" do
    name = 'user'
    run_generator
    assert_model(name)    
  end

  test "invoke with model name" do
    name = 'admin'
    run_generator(name)
    assert_model(name)
  end
end
