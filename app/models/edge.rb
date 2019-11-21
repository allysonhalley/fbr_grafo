class Edge < ApplicationRecord
  belongs_to :graph
  belongs_to :initial_vertex, class_name: 'Vertex'
  belongs_to :final_vertex, class_name: 'Vertex'

  # All in edges on this vertex
  scope :equal_initial_vertices, -> (vertex) {
    where(initial_vertex_id: vertex)
  }
  # All out edges on this vertex
  scope :equal_final_vertices, -> (vertex) {
    where(final_vertex_id: vertex)
  }

  #Retourn initial edges form initial vertex
  scope :initial_edges, -> {
    where(initial_vertex_id: Vertex.start_vertex)
  }

  scope :list_edges, -> (vertex) {
    where(initial_vertex_id: vertex)
  }
  
  def next_edges
    Edge.where(initial_vertex: self.final_vertex)
  end

  #Return a name to edge
  def step_name
    "=> #{initial_vertex.name}#{final_vertex.name} "
  end

end
