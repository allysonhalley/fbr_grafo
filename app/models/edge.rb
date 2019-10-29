class Edge < ApplicationRecord
  belongs_to :graph
  belongs_to :initial_vertex, class_name: 'Vertex'
  belongs_to :final_vertex, class_name: 'Vertex'

  scope :initial_a_vertex, -> {where(initial_vertex: Vertex.find_by(name: 'A'))}
  scope :initial_b_vertex, -> {where(initial_vertex: Vertex.find_by(name: 'B'))}
  scope :initial_c_vertex, -> {where(initial_vertex: Vertex.find_by(name: 'C'))}
  scope :initial_d_vertex, -> {where(initial_vertex: Vertex.find_by(name: 'D'))}
  scope :final_b_vertex, -> {where(final_vertex: Vertex.find_by(name: 'B'))}
  scope :final_c_vertex, -> {where(final_vertex: Vertex.find_by(name: 'C'))}
  scope :final_d_vertex, -> {where(final_vertex: Vertex.find_by(name: 'D'))}
  scope :final_e_vertex, -> {where(final_vertex: Vertex.find_by(name: 'E'))}

  # All in edges on this vertex
  scope :equal_initial_vertices, -> (vertex) {
    where(initial_vertex_id: vertex)
  }
  # All out edges on this vertex
  scope :equal_final_vertices, -> (vertex) {
    where(final_vertex_id: vertex)
  }
  #Go to the target vertex
  scope :next_vertex, -> (vertex) {
    where(final_vertex_id: vertex)
  }

end
