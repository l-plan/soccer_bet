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
      when /^alg/
        "Algeria"
      when /^age|^arg/
        "Argentina"
      when /^austra/
        "Australia"
      when /^austria|^oost/
        "Austria"
      when /^belg|^berl/
        "Belgium"
      when /^bosn/
        "Bosnië-Herzegovina"
      when /^bra/
        "Brazil"
      when /^can/
        "Canada"
      when /^cap|^kaa/
        "Cape Verde"
      when /^col/
        "Colombia"
      when /^cro|^kro/
        "Croatia"
      when /^cur/
        "Curaçao"
      when /^con|^dr/
        "DR Congo"
      when /^den/
        "not-found"
      when /^ecu|^equ/
        "Ecuador"
      when /^eg|^eqy/
        "Egypt"
      when /^eng/
        "England"
      when /^fra/
        "France"
      when /^du|^ger/
        "Germany"
      when /^gh/
        "Ghana"
      when /^alg/
        "Haiti"
      when /^irak/
        "Irak"
      when /^iran/
        "Iran"
      when /^ita/
        "not-found"
      when /^iv/
        "Ivory Coast"
      when /^ja/
        "Japan"
      when /^alg/
        "Jordan"
      when /^mex/
        "Mexico"
      when /^mar|^mor/
        "Morocco"
      when /^ned|^neth/
        "Netherlands"
      when /^new|^nieu/
        "New Zealand"
      when /^nig/
        "not-found"
      when /^noor|^nor/
        "Norway"
      when /^oek/
        "not-found"
      when /^pan/
        "Panama"
      when /^para/
        "Paraguay"
      when /^pol/
        "not-found"
      when /^por/
        "Portugal"
      when /^qat/
        "Qatar"
      when /^sa/
        "Saudi Arabia"
      when /^sc/
        "Scotland"
      when /^sen/
        "Senegal"
      when /^ser/
        "not-found"
      when /africa|afrika/
        "South Africa"
      when /korea/
        "South Korea"
      when /^spain|^span/
        "Spain"
      when /^swi|^zwi/
        "Switzerland"
      when /^cz|^tje|^tsj/
        "Tsjechië"
      when /^tun/
        "Tunisia"
      when /^tur|rkiye/
        "Turkije"
      when /^ura|^uru/
        "Uruguay"
      when /^ame|^unite|^usa|^ver|^vs/
        "USA"
      when /^oez|^uzb/
        "Uzbekistan"
      when /^swe|^zwe/
        "Zweden"
      end

  end
        
end
