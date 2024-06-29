module ApplicationHelper

	
    def nld(date)
      date.strftime( '%d %b %Y') if date
    end


    def nldt(datetime)
      datetime.strftime( '%d %b %Y %H:%M') if datetime
    end
    
    alias :nldate :nld 

    def nlt(time)
      time.strftime( '%H:%M') if time
    end

    def dayt(datetime)
      datetime.strftime( '%a %d %b  %H:%M') if datetime
    end


    def check?(value)
      val = "-"
      val = "V" if value==true
      val
    end
        
end
