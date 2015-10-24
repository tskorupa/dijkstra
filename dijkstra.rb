class Dijkstra

  def initialize graph
    @graph = graph
  end

  def find initial_node, destination_node
    @destination_node = destination_node

    set_current_node initial_node
    initialize_sets
    initialize_distances

    find_recur

    return shortest_distance
  end

  private

  def shortest_distance
    @distances[@destination_node]
  end

  def find_recur
    return if !@unvisited_nodes.include?(@destination_node)

    calculate_distance_to_neighbours
    remove_current_node_from_unvisited
    set_current_node unvisited_node_with_smallest_distance
    return if @current_node.nil?

    find_recur
  end

  def unvisited_node_with_smallest_distance
    node, min = nil, Float::INFINITY

    @unvisited_nodes.each do |candidate_node|
      if (tentative_distance = @distances[candidate_node]) < min
        node, min = candidate_node, tentative_distance
      end
    end

    node
  end

  def remove_current_node_from_unvisited
    @unvisited_nodes.delete @current_node
  end

  def calculate_distance_to_neighbours
    unvisited_neighbours.each do |neighbour|
      tentative_distance = @distances[@current_node] + @graph[@current_node][neighbour]
      assigned_distance = @distances[neighbour]

      if tentative_distance < assigned_distance
        @distances[neighbour] = tentative_distance
      end
    end
  end

  def unvisited_neighbours
    neighbours = @graph[@current_node].keys
    @unvisited_nodes & neighbours
  end

  def initialize_distances
    @distances ||= {}
    @all_nodes.each do |node|
      @distances[node] = (node == @current_node) ? 0 : Float::INFINITY
    end
  end

  def initialize_sets
    @all_nodes = @graph.keys
    @unvisited_nodes = @all_nodes - [ @current_node ]
  end

  def set_current_node current_node
    @current_node = current_node
  end

end
