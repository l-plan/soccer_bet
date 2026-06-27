require "test_helper"

class Fifa::RankingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fifa_ranking = fifa_rankings(:one)
  end

  test "should get index" do
    get fifa_rankings_url
    assert_response :success
  end

  test "should get new" do
    get new_fifa_ranking_url
    assert_response :success
  end

  test "should create fifa_ranking" do
    assert_difference("Fifa::Ranking.count") do
      post fifa_rankings_url, params: { fifa_ranking: { points: @fifa_ranking.points, team_id: @fifa_ranking.team_id } }
    end

    assert_redirected_to fifa_ranking_url(Fifa::Ranking.last)
  end

  test "should show fifa_ranking" do
    get fifa_ranking_url(@fifa_ranking)
    assert_response :success
  end

  test "should get edit" do
    get edit_fifa_ranking_url(@fifa_ranking)
    assert_response :success
  end

  test "should update fifa_ranking" do
    patch fifa_ranking_url(@fifa_ranking), params: { fifa_ranking: { points: @fifa_ranking.points, team_id: @fifa_ranking.team_id } }
    assert_redirected_to fifa_ranking_url(@fifa_ranking)
  end

  test "should destroy fifa_ranking" do
    assert_difference("Fifa::Ranking.count", -1) do
      delete fifa_ranking_url(@fifa_ranking)
    end

    assert_redirected_to fifa_rankings_url
  end
end
