class Way < ApplicationRecord

    def self.run_ways        
        #Descobre o início      
        vertex_in = Vertex.start_vertex
        #Lista as aresta do vertice        
        next_step(vertex_in)
    end

    #Segue as aresta escrevendo e fazendo o registro por profundidade
    def self.next_step(vertex_in)
        edges_list_in = Edge.where(initial_vertex: vertex_in)
        # beggin each edges_list_in
        edges_list_in.each do |edge|   
            way = Way.new
            way.edges_list = "#{edge.graph.name} #{write_step(edge)}"             
            if (edge.final_vertex.is_end_vertex)
                way.register_steps(edge)
                way.save
            else
                #escreve um passo
                way.register_steps(edge)
                #Recursividade                
                next_step(edge.final_vertex)
            end
        end
        ## end each edges_list_in
    end

    #Registra cada avanço (aresta)
    def self.write_step(edge)
        "=> #{edge.initial_vertex.name} - #{edge.final_vertex.name}"
    end
    def self.sum_time(edge)
        total_time = total_time + edge.time
        total_time
    end
    def self.sum_distane(edge)
        total_distance = total_distance + edge.distance
        total_distance
    end
    def self.register_steps(edge)
        write_step(edge)
        sum_time(edge)
        sum_distane(edge)            
    end   
end
