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
    vertex_in = Vertex.start_vertex
    #Variáveis local auxiliam durante percurso
    initial_distance = 0
    initial_time = 0
    partial_vertices = ''
    partial_edges = ''    
    #Variáveis
    #Chamada de método para início do percurso
    map_ways(vertex_in, partial_vertices, partial_edges, initial_distance, initial_time)
    redirect_to graphs_url, notice: 'Way was successfully mapped.'
  end

  def reset_ways
    Way.delete_all
    redirect_to graphs_url, notice: 'Way was successfully cleaned.'
  end

  private
    #Segue os caminhos registrando e salvando os passos, tempo e distância
    #Método garante a recursividade e promove percorrer todos os camihos
    def map_ways(vertex, partial_vertices, partial_edges, partial_distance, partial_time)
      partial_distance = partial_distance
      partial_time = partial_time
      edges_in = Edge.list_edges(vertex)      
      edges_in.each do |edge|
        #Entra no final do caminho pra salvar
        if(edge.final_vertex.is_end_vertex)
          #Salva nos atributos do caminho o valor das variáveis
          partial_vertices << edge.initial_vertex.name
          partial_vertices << edge.final_vertex.name
          partial_edges << edge.step_name
          # partial_distance += edge.distance
          # partial_time += edge.time
          #Cria camiho já com os valores preenchido
          way = Way.new(
            vertices_list: partial_vertices,
            edges_list: partial_edges,
            total_distance: partial_distance + edge.distance,
            total_time: partial_time + edge.time
            )
          #Persiste um caminho totalmente percorrido
          way.save
          way = Way.new
          # abort way.inspect
          #Reinicia variáveis
          partial_vertices.clear
          partial_edges.clear
          partial_distance = 0
          partial_time = 0          
          #Segue pro próximo laço  
        else
          #Incrementa as variáveis pra serem inseridas e salvas no fundo do caminho
          partial_vertices << edge.initial_vertex.name
          partial_edges << edge.step_name
          partial_distance = partial_distance + edge.distance
          partial_time = partial_time + edge.time
          #Entra mais um nível em profundididade
          map_ways(edge.final_vertex, partial_vertices, partial_edges, partial_distance, partial_time)
        end
      end
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
