require "test_helper"

class ImportGamesTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @file = ImportFile.new.file.each_with_pagename
    @games = []
  end
    


  test 'check participants amount ' do
    @participants = []
      @file.each do |name, sheet|
        next if name =~/Deelnemers/
        part =  sheet.cell(3,2)
        email = sheet.cell(4,2)
        @participants.push Participant.new(name: part, email: email)

      end
    assert_equal 41, @participants.compact.size
  end

  test 'check participants names ' do
    @participants = []
      @file.each do |name, sheet|
        next if name =~/Deelnemers/
        part =  sheet.cell(3,2)
        email = sheet.cell(4,2)
        @participants.push Participant.new(name: part, email: email)

      end
    assert_equal 41, @participants.compact.map(&:name).uniq.size
  end

  test 'check participants email-addresses ' do
    @participants = []
      @file.each do |name, sheet|
        next if name =~/Deelnemers/
        part =  sheet.cell(3,2)
        email = sheet.cell(4,2)
        @participants.push Participant.new(name: part, email: email)

      end
    assert_equal 24, @participants.compact.map(&:email).uniq.size
  end



end