require 'test_helper'

class VerticesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vertex = vertices(:one)
  end

  test "should get index" do
    get vertices_url
    assert_response :success
  end

  test "should get new" do
    get new_vertex_url
    assert_response :success
  end

  test "should create vertex" do
    assert_difference('Vertex.count') do
      post vertices_url, params: { vertex: { nome: @vertex.nome } }
    end

    assert_redirected_to vertex_url(Vertex.last)
  end

  test "should show vertex" do
    get vertex_url(@vertex)
    assert_response :success
  end

  test "should get edit" do
    get edit_vertex_url(@vertex)
    assert_response :success
  end

  test "should update vertex" do
    patch vertex_url(@vertex), params: { vertex: { nome: @vertex.nome } }
    assert_redirected_to vertex_url(@vertex)
  end

  test "should destroy vertex" do
    assert_difference('Vertex.count', -1) do
      delete vertex_url(@vertex)
    end

    assert_redirected_to vertices_url
  end
end
