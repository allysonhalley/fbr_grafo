class WaysController < ApplicationController
  before_action :set_way, only: [:show, :edit, :update, :destroy]

  # GET /ways
  # GET /ways.json
  def index
    @ways = Way.all
    # abort @ways.inspect
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
    #Descobre o início      
    # vertex_in = Vertex.start_vertex
    #Lista as aresta do vertice    
    # edges_in = Edge.initial_edges
    way = Way.new
    map_ways(way, Edge.initial_edges)    
    redirect_to ways_url, notice: 'Way was successfully destroyed.'
  end

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
    def map_ways(way, edges_in)               
      edges_in.each do |edge|        
        if(edge.final_vertex.is_end_vertex)
          register_way = Way.new
          register_way = way
          register_way.register_step(edge)   
          # abort register_way.inspect       
        else
          way.register_step(edge)
          map_ways(way, Edge.next_edges(edge.final_vertex))
        end
      end
    end

    # refazendo o q foi comentado embaixo
    #################################################    
      #     if (edge.final_vertex.is_end_vertex)
      #       # abort way.inspect
      #       way.register_step(edge)
      #       way.save
      #       way = Way.new
      #     elsif (way.total_distance == 0)
      #       # abort edge.final_vertex.is_end_vertex.inspect
      #       # abort way.inspect         
      #       #escreve um passo
      #       way.register_step(edge)
      #       #Recursividade              
      #       # abort way.inspect  
      #     else
      #       abort way.inspect         
      #       #escreve um passo
      #       way.register_step(edge)
      #       #Recursividade              
      #       # abort way.inspect            
      #     end
      # end
      ## end each edges_in
      # end
    ###########################################################  
    
    # #Registra cada avanço (aresta)
    # def write_step(edge)
    #   "=> #{edge.initial_vertex.name} - #{edge.final_vertex.name}"
    # end
    # def sum_time(edge)
    #     total_time = total_time + edge.time
    #     total_time
    # end
    # def sum_distane(edge)
    #     total_distance = total_distance + edge.distance
    #     total_distance
    # end
    # def register_steps(way,edge)            
    #   way.register_step(edge)
    # end
end
