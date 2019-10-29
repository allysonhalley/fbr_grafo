require 'test_helper'

class WaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @way = ways(:one)
  end

  test "should get index" do
    get ways_url
    assert_response :success
  end

  test "should get new" do
    get new_way_url
    assert_response :success
  end

  test "should create way" do
    assert_difference('Way.count') do
      post ways_url, params: { way: { edges_list: @way.edges_list, total_distance: @way.total_distance, total_time: @way.total_time, vertices_list: @way.vertices_list } }
    end

    assert_redirected_to way_url(Way.last)
  end

  test "should show way" do
    get way_url(@way)
    assert_response :success
  end

  test "should get edit" do
    get edit_way_url(@way)
    assert_response :success
  end

  test "should update way" do
    patch way_url(@way), params: { way: { edges_list: @way.edges_list, total_distance: @way.total_distance, total_time: @way.total_time, vertices_list: @way.vertices_list } }
    assert_redirected_to way_url(@way)
  end

  test "should destroy way" do
    assert_difference('Way.count', -1) do
      delete way_url(@way)
    end

    assert_redirected_to ways_url
  end
end
