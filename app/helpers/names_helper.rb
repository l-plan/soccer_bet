module NamesHelper

  def set_participant(sheet)
    part =  sheet.cell(3,2)
    email = sheet.cell(4,2)
    @participant = Participant.find_by(name: part, email: email) || Participant.new(name: part, email: email)
  end

# first find all name-entrys, stripped, downcased and uniq as returned by method test_team_names
# list the 24 official names from the database
# try to match each entry by the first 1-2-3-4 letters to only one of an official name
# return the official name


  def return_official_player_name(entry)
    case entry
      when /bell/
        "bellingham"
      when /depa|memp|meph/
        "depay"
      when /dijk/
        "virgil van dijk"
      when /dolb/
        "kasper dolberg"
      when /fern/
         "bruno fernandez"
      when /fode/
        "phil foden"
      when /frim|jerem/
        "frimpong"
      when /full/
        "fullkrug"
      when /have/
        "havertz"
      when /kane/
        "harry kane"
      when /kroo/
        "kroos"
      when /luka/
        "lukaku"
      when /mbap|nbap|m'bap/
        "killian mbappe"
      when /rona/
        "ronaldo"
      when /saka/
        "bukayo saka"
      when /simo/
        "simons"
      when /wirt/
         "florian wirtz"
      when /wout/
         "wout weghorst"

    end


  end


  def return_official_team_name(entry)
    case entry.downcase 



      when /^alb/
        "Albanie"
      when /^bel/
        "Belgie"
      when /^den/
        "Denemarken"
      when /^dui/
        "Duitsland"
      when /^en/
        "Engeland"
      when /^fr/
        "Frankrijk"
      when /^geo|^goerg/
        "Georgie"
      when /^hon/
        "Hongarije"
      when /^ita/
        "Italie"
      when /^kro/
        "Kroatie"
      when /^ned/
        "Nederland"
      when /^oek|^ukr/
        "Oekraine"
      when /^oos|^oss/
        "Oostenrijk"
      when /^pol/
        "Polen"
      when /^por/
        "Portugal"
      when /^roe/
        "Roemenie"
      when /^sch/
        "Schotland"
      when /^ser/
        "Servie"
      when /^slov/
        "Slovenie"
      when /^slow/
        "Slowakije"
      when /^spa/
        "Spanje"
      when /^tje|^tsj/
        "Tjechie"
      when /^tur/
        "Turkije"
      when /^zwi/
        "Zwitserland"

    end
  end
        
end
