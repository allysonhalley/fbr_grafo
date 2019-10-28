class Vertex < ApplicationRecord
    
    scope :start_vertex, -> {
        where.not(id: Edge.select(
        :final_vertex_id).group(
        :final_vertex_id).all.map(&:final_vertex_id))
    }
    scope :end_vertex, -> {
        where.not(id: Edge.select(
        :initial_vertex_id).group(
        :initial_vertex_id).all.map(&:initial_vertex_id))
    }

end 
