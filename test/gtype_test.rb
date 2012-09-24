require 'test/unit'
require './gtype'

class StringTest < Test::Unit::TestCase
  def test_to_gtypist_first_line
    assert_equal "hola".to_gtypist_first_line, "D:hola"
  end

  def test_to_gtypist
    assert_equal "hola".to_gtypist, " :hola"
  end
end

class GtypeTest < Test::Unit::TestCase
  def setup
    @gtype = Gtype.new(["one", "two"], 'test.rb')
  end

  def test_process
    assert_equal ["D:one", " :two"], @gtype.process()
  end

  def test_write
    @gtype.write()
    opened_lines = []
    open(@gtype.path, 'r').each { |x| opened_lines << x }
    assert_equal ["D:one\n", " :two\n"], opened_lines
  end

  def teardown
    File.delete(@gtype.path) if File.exists?(@gtype.path)
  end
end
