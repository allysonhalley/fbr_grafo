class WaysController < ApplicationController
  before_action :set_way, only: [:show, :edit, :update, :destroy]

  # GET /ways
  # GET /ways.json
  def index
    @ways = Way.all
  end

  # GET /ways/1
  # GET /ways/1.json
  def show    
  end

  # GET /ways/new
  def new
    @way = Way.new
  end

  # GET /ways/1/edit
  def edit
  end

  # POST /ways
  # POST /ways.json
  def create
    @way = Way.new(way_params)

    respond_to do |format|
      if @way.save
        format.html { redirect_to @way, notice: 'Way was successfully created.' }
        format.json { render :show, status: :created, location: @way }
      else
        format.html { render :new }
        format.json { render json: @way.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ways/1
  # PATCH/PUT /ways/1.json
  def update
    respond_to do |format|
      if @way.update(way_params)
        format.html { redirect_to @way, notice: 'Way was successfully updated.' }
        format.json { render :show, status: :ok, location: @way }
      else
        format.html { render :edit }
        format.json { render json: @way.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ways/1
  # DELETE /ways/1.json
  def destroy
    @way.destroy
    respond_to do |format|
      format.html { redirect_to ways_url, notice: 'Way was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def run_ways        
    # way = Way.new
    # way.default_fill
    # edges_in = Edge.initial_edges
    vertex_in = Vertex.start_vertex
    initial_distance = 0
    initial_time = 0
    partial_vertices = ''
    partial_edges = ''
    # map_ways(way, edges_in)
    map_ways(vertex_in, partial_vertices, partial_edges, initial_distance, initial_time)
    redirect_to ways_url, notice: 'Way was successfully mapped.'
  end

  # def reset_ways
  #   Way.delete_all
  #   redirect_to ways_url, notice: 'Way was successfully cleaned.'
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_way
      @way = Way.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def way_params
      params.require(:way).permit(:vertices_list, :edges_list, :total_distance, :total_time)
    end
    
    #Segue as aresta escrevendo e fazendo o registro por profundidade
    # def map_ways(way, edges_in)
    # def map_ways(vertex, partial_vertices, partial_edges, partial_distance, partial_time)
    #   edges_in = Edge.list_edges(vertex)      
    #   edges_in.each do |edge|
    #     if(edge.final_vertex.is_end_vertex)
    #       # register_way = Way.new
    #       # register_way.default_fill
    #       # register_way.change_new_way(way)
    #       # register_way.register_step(edge)
    #       # way.register_step(edge)
    #       partial_vertices << edge.initial_vertex.name
    #       partial_vertices << edge.final_vertex.name
    #       partial_edges << edge.step_name
    #       partial_distance += edge.distance
    #       partial_time += edge.time
    #       # abort edge.final_vertex.inspect          
    #       way = Way.new(
    #         vertices_list: partial_vertices,
    #         edges_list: partial_edges,
    #         total_distance: partial_distance,
    #         total_time: partial_time
    #         )
    #       # abort way.inspect
    #       way.save
          
    #       partial_vertices.clear
    #       partial_edges.clear
    #       partial_distance = 0
    #       partial_time = 0
          

    #     # abort way.inspect
    #     # elsif way.is_continuity(edge)
    #     #   way.register_step(edge)          
    #     #   # next_edges com falha por hora
    #     #   map_ways(way, edge.next_edges)
    #     #   abort edge.initial_vertex.inspects        
    #     else
    #       # edge.initial_vertex.is_start_vertex
    #       # abort edge.inspect
    #       # way.register_step(edge)
    #       # abort edge.next_edges.inspect
    #       partial_vertices << edge.initial_vertex.name
    #       partial_edges << edge.step_name
    #       partial_distance += edge.distance
    #       partial_time += edge.time
    #       map_ways(edge.final_vertex, partial_vertices, partial_edges, partial_distance, partial_time)
    #     # else
    #     #   # abort edge.inspect  
    #     #   way.register_step(edge)
    #     #   map_ways(way, edge.next_edges)
    #     end
    #   end
    # end

    # def add_step(edge, partial_vertices, partial_edges, partial_distance, partial_time)
    # # def add_step(edge)
    #   partial_vertices =+ edge.initial_vertex.name
    #   partial_edges =+ edge.step_name
    #   partial_distance =+ edge.distance
    #   partial_time =+ edge.time
    # end
end
