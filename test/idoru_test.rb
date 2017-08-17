require 'test_helper'

class IdoruTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Idoru::VERSION
  end

  def test_it_does_something_useful
    Idoru.logger.info('foo')
  end
end
