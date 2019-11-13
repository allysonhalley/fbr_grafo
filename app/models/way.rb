class Way < ApplicationRecord
    
    validates :edges_list, presence: true, uniqueness: true

    def default_fill
        self.vertices_list = ''
        self.edges_list = ''
        self.total_distance = 0
        self.total_time = 0
    end

    def new(vertices_list, edges_list, total_distance, total_time)
        self.vertices_list = vertices_list
        self.edges_list = edges_list
        self.total_distance = total_distance
        self.total_time = total_time
    end

    def change_new_way(way)        
        self.vertices_list = String.new(way.vertices_list.to_s)
        self.edges_list = String.new(way.edges_list.to_s)
        self.total_distance = way.total_distance.to_int
        self.total_time = way.total_time.to_int
    end

    # def back_step
    #     self
    # end

    def register_step(edge)    
        if vertices_list.empty?
            self.vertices_list = edge.initial_vertex.name
        end        
        self.vertices_list << edge.final_vertex.name        
        self.edges_list << " => #{edge.step_name}"
        self.total_distance += edge.distance
        self.total_time += edge.time
        self.save
    end 

    def is_continuity(edge)        
        self.vertices_list.include?(edge.initial_vertex.name)
    end
end
