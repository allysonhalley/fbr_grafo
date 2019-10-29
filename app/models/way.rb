class Way < ApplicationRecord

    after_initialize :default_fill
    
    validates :edges_list, presence: true, uniqueness: true

    def default_fill
        self.vertices_list = ''
        self.edges_list = ''
        self.total_distance = 0
        self.total_time = 0
    end

    def register_step(edge)    
        if vertices_list.empty?
            self.vertices_list = edge.initial_vertex.name
        end        
        self.vertices_list = self.vertices_list + "#{edge.final_vertex.name}"
        if edges_list.empty?
            self.edges_list = edge.graph.name
        end        
        self.edges_list = self.edges_list + " => #{edge.initial_vertex.name} - #{edge.final_vertex.name}"
        self.total_distance = total_distance + edge.distance
        self.total_time = total_time + edge.time
        self.save
    end
end
