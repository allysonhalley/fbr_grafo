class Way < ApplicationRecord
    
    validates :edges_list, presence: true, uniqueness: true

    def default_fill
        self.vertices_list = ''
        self.edges_list = ''
        self.total_distance = 0
        self.total_time = 0
    end

    def change_new_way(way)
        self.vertices_list = way.vertices_list
        self.edges_list = way.edges_list
        self.total_distance = way.total_distance
        self.total_time = way.total_time
    end

    def register_step(edge)    
        if vertices_list.empty?
            self.vertices_list = edge.initial_vertex.name
        end        
        self.vertices_list = (self.vertices_list + "#{edge.final_vertex.name}").to_str
        if edges_list.empty?
            self.edges_list = edge.graph.name.to_str
        end        
        self.edges_list = self.edges_list + " => #{edge.initial_vertex.name} - #{edge.final_vertex.name}"
        self.total_distance = total_distance + edge.distance
        self.total_time = total_time + edge.time
        self.save
    end
end
