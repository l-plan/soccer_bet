require "test_helper"

class ImportGamesTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @import = ImportFile.new
    @file = @import.file.each_with_pagename
  end
    


  test 'check games amount ' do
      @participants = []
      @file.each do |name, sheet|
        next if name =~/Deelnemers/

        # part =  sheet.cell(3,2)
        # email = sheet.cell(4,2)
        # @participants.push @participant = Participant.new(name: part, email: email)
        @import.import_games(sheet)

      end


    # assert_equal 41, @participants.flat_map{|x| x.games}.size
    assert_equal 41, Game.all.size
  end

  # test 'check games names ' do
  #   @games = []
  #     @file.each do |name, sheet|
  #       next if name =~/Deelnemers/
  #       part =  sheet.cell(3,2)
  #       email = sheet.cell(4,2)
  #       @games.push Participant.new(name: part, email: email)

  #     end
  #   assert_equal 41, @games.compact.map(&:name).uniq.size
  # end

  # test 'check games email-addresses ' do
  #   @games = []
  #     @file.each do |name, sheet|
  #       next if name =~/Deelnemers/
  #       part =  sheet.cell(3,2)
  #       email = sheet.cell(4,2)
  #       @games.push Participant.new(name: part, email: email)

  #     end
  #   assert_equal 24, @games.compact.map(&:email).uniq.size
  # end



end