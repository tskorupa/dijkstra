require_relative "dijkstra"
require "minitest/autorun"

class TestDijkstra < MiniTest::Unit::TestCase

  def test_1
    graph = {
      a: { b:1, e:1 },
      b: { a:1, c:1 },
      c: { b:1, d:1 },
      d: { c:1, e:1, f:1 },
      e: { a:1, d:1 },
      f: { d:1, g:1 },
      g: { f:1 }
    }
    assert_equal 4, Dijkstra.new(graph).find(:a, :g)
  end

  def test_2
    graph = {
      x: { y:1, w:1 },
      y: { x:1, z:1 },
      z: { y:1 },
      w: { x: 1 }
    }
    assert_equal 1, Dijkstra.new(graph).find(:x, :w)
  end

  def test_3
    graph = {
      a: { b:1, c:1 },
      b: { a:1, c:1 },
      c: { a:1, b:1, d:1 },
      d: { c:1, f:1 },
      f: { d:1 }
    }
    assert_equal 3, Dijkstra.new(graph).find(:a, :f)
  end

  def test_4
    graph = {
      a: { b:1, e:1 },
      b: { a:1, c:1 },
      c: { b:1, d:1 },
      d: { c:1, e:1, f:1 },
      e: { a:1, d:1 },
      f: { d:1 },
      g: { }
    }
    assert_equal Float::INFINITY, Dijkstra.new(graph).find(:a, :g)
  end

end
