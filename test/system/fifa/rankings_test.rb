require "application_system_test_case"

class Fifa::RankingsTest < ApplicationSystemTestCase
  setup do
    @fifa_ranking = fifa_rankings(:one)
  end

  test "visiting the index" do
    visit fifa_rankings_url
    assert_selector "h1", text: "Rankings"
  end

  test "should create ranking" do
    visit fifa_rankings_url
    click_on "New ranking"

    fill_in "Points", with: @fifa_ranking.points
    fill_in "Team", with: @fifa_ranking.team_id
    click_on "Create Ranking"

    assert_text "Ranking was successfully created"
    click_on "Back"
  end

  test "should update Ranking" do
    visit fifa_ranking_url(@fifa_ranking)
    click_on "Edit this ranking", match: :first

    fill_in "Points", with: @fifa_ranking.points
    fill_in "Team", with: @fifa_ranking.team_id
    click_on "Update Ranking"

    assert_text "Ranking was successfully updated"
    click_on "Back"
  end

  test "should destroy Ranking" do
    visit fifa_ranking_url(@fifa_ranking)
    click_on "Destroy this ranking", match: :first

    assert_text "Ranking was successfully destroyed"
  end
end
