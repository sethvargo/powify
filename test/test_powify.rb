require 'helper'

class TestPowify < Test::Unit::TestCase
  context "powify app" do
    setup do
      
    end
    
    should 'have all available methods' do
      assert_equal Powify::App::AVAILABLE_METHODS, %w(create link new destroy unlink remove restart browse open rename logs help)
    end
  end
end