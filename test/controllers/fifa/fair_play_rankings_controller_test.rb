require "test_helper"

class Fifa::FairPlayRankingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fifa_fair_play_ranking = fifa_fair_play_rankings(:one)
  end

  test "should get index" do
    get fifa_fair_play_rankings_url
    assert_response :success
  end

  test "should get new" do
    get new_fifa_fair_play_ranking_url
    assert_response :success
  end

  test "should create fifa_fair_play_ranking" do
    assert_difference("Fifa::FairPlayRanking.count") do
      post fifa_fair_play_rankings_url, params: { fifa_fair_play_ranking: { points: @fifa_fair_play_ranking.points, team_id: @fifa_fair_play_ranking.team_id } }
    end

    assert_redirected_to fifa_fair_play_ranking_url(Fifa::FairPlayRanking.last)
  end

  test "should show fifa_fair_play_ranking" do
    get fifa_fair_play_ranking_url(@fifa_fair_play_ranking)
    assert_response :success
  end

  test "should get edit" do
    get edit_fifa_fair_play_ranking_url(@fifa_fair_play_ranking)
    assert_response :success
  end

  test "should update fifa_fair_play_ranking" do
    patch fifa_fair_play_ranking_url(@fifa_fair_play_ranking), params: { fifa_fair_play_ranking: { points: @fifa_fair_play_ranking.points, team_id: @fifa_fair_play_ranking.team_id } }
    assert_redirected_to fifa_fair_play_ranking_url(@fifa_fair_play_ranking)
  end

  test "should destroy fifa_fair_play_ranking" do
    assert_difference("Fifa::FairPlayRanking.count", -1) do
      delete fifa_fair_play_ranking_url(@fifa_fair_play_ranking)
    end

    assert_redirected_to fifa_fair_play_rankings_url
  end
end
