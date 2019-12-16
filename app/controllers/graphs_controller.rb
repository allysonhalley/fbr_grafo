class GraphsController < ApplicationController
  before_action :set_graph, only: [:show, :edit, :update, :destroy]

  # GET /graphs
  # GET /graphs.json
  def index
    #Junção de todas as ações em uma só tela 
    @graph = Graph.find_by(name: 'Alpha')    
    @vertices = Vertex.all
    @edges = Edge.all
    @ways = Way.all
    @minor_time = Way.minor_time.first
    @minor_distance = Way.minor_distance.first
    # render json: Way.all

  end

  # GET /graphs/1
  # GET /graphs/1.json
  def show
  end

  # GET /graphs/new
  def new
    @graph = Graph.new
  end

  # GET /graphs/1/edit
  def edit
  end

  # POST /graphs
  # POST /graphs.json
  def create
    @graph = Graph.new(graph_params)

    respond_to do |format|
      if @graph.save
        format.html { redirect_to @graph, notice: 'Graph was successfully created.' }
        format.json { render :show, status: :created, location: @graph }
      else
        format.html { render :new }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graphs/1
  # PATCH/PUT /graphs/1.json
  def update
    respond_to do |format|
      if @graph.update(graph_params)
        format.html { redirect_to @graph, notice: 'Graph was successfully updated.' }
        format.json { render :show, status: :ok, location: @graph }
      else
        format.html { render :edit }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graphs/1
  # DELETE /graphs/1.json
  def destroy
    @graph.destroy
    respond_to do |format|
      format.html { redirect_to graphs_url, notice: 'Graph was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Percorre todos os caminhos
  def run_ways            
    @@stack_edges = Array.new
    #Variável garante o início do do algorítmo
    vertex_in = Vertex.start_vertex
    map_ways(vertex_in)
    redirect_to graphs_url, notice: 'Way was successfully mapped.'
  end

  def reset_ways
    Way.delete_all
    redirect_to graphs_url, notice: 'Way was successfully cleaned.'
  end

  private
    #Segue os caminhos registrando e salvando os passos, tempo e distância
    #Método garante a recursividade e garante percorrer todos os caminhos    
    def map_ways(vertex)      
      edges_in = Edge.list_edges(vertex)      
      edges_in.each do |edge|
        #Entra no final do caminho pra salvar
        if(edge.final_vertex.is_end_vertex)
          #Salva nos atributos do caminho o valor das variáveis
          @@stack_edges << edge
          #Cria e salva o caminho
          create_a_way(@@stack_edges)          
        else
          #Entra mais um nível em profundididade
          @@stack_edges << edge
          map_ways(edge.final_vertex)
        end
      end
    end
    
    # Cria e salva way
    def create_a_way(stack_edges)
      partial_vertices = ""      
      partial_edges = ""
      partial_distance = 0
      partial_time = 0
      stack_edges.each do |edge_push|
        if edge_push == stack_edges.first
          partial_vertices << edge_push.initial_vertex.name
        end
        partial_vertices << edge_push.final_vertex.name                
        partial_edges << edge_push.step_name
        partial_distance += edge_push.distance
        partial_time += edge_push.time
      end
      #Cria e preenche os atributos e way
      way = Way.new(
            vertices_list: partial_vertices,
            edges_list: partial_edges,
            total_distance: partial_distance,
            total_time: partial_time
            )
      way.save
      #Reinicia todas as variáveis
      way.default_fill      
      partial_vertices.clear
      partial_edges.clear
      partial_distance = 0
      partial_time = 0
      @@stack_edges.clear
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_graph
      @graph = Graph.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graph_params
      params.require(:graph).permit(:name)
    end
end
