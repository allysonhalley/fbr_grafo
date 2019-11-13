class Way < ApplicationRecord
    
    validates :edges_list, presence: true, uniqueness: true

    scope :minor_time, -> {
        where(total_time: minimum(:total_time))
    }
    scope :minor_distance, -> {
        where(total_distance: minimum(:total_distance))
    }

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
end
