class Edge < ApplicationRecord
  belongs_to :graph
  belongs_to :initial_vertex, class_name: 'Vertex'
  belongs_to :final_vertex, class_name: 'Vertex'

  

end
