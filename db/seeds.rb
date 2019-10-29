# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

##############################################################################################################################################
#############################################################SCRIPTS CREATE TABLE#############################################################
#rails g scaffold graph name:string
#rails g scaffold vertex name:string
#rails g scaffold edge graphgit :references initial_vertex:references final_vertex:references time:integer distance:integer
#rails g scaffold way vertices_list:text edges_list:text total_distance:integer total_time:integer
##############################################################################################################################################
##############################################################################################################################################

# Insert defaults Graphs elements
Graph.destroy_all

Graph.create!([ {name: "Alpha"}])

p "Created #{Graph.count} graphs!"

# Insert defaults Vertices elements
Vertex.destroy_all

Vertex.create!([
    {name: "A"},
    {name: "B"},
    {name: "C"},
    {name: "D"},
    {name: "E"}
])

p "Created #{Vertex.count} vertices!"

# Insert defaults Edges elements
Edge.destroy_all

g = Graph.find_by(name: "Alpha")
v_a = Vertex.find_by(name: "A")
v_b = Vertex.find_by(name: "B")
v_c = Vertex.find_by(name: "C")
v_d = Vertex.find_by(name: "D")
v_e = Vertex.find_by(name: "E")

Edge.create!([
    {graph: g, initial_vertex: v_a, final_vertex: v_b, time: 1, distance: 18},
    {graph: g, initial_vertex: v_a, final_vertex: v_c, time: 6, distance: 3},
    {graph: g, initial_vertex: v_a, final_vertex: v_d, time: 2, distance: 15},
    {graph: g, initial_vertex: v_b, final_vertex: v_d, time: 5, distance: 6},
    {graph: g, initial_vertex: v_c, final_vertex: v_d, time: 3, distance: 12},
    {graph: g, initial_vertex: v_d, final_vertex: v_e, time: 4, distance: 9}
])

p "Created #{Edge.count} edges!"

p "Seeds successed!"