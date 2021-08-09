class PagesController < ApplicationController

  def welcome
  
    @routers_default = Gmaps4rails.build_markers(State.all) do |plot, marker|  
      marker.lat plot.latitude  
      marker.lng plot.longitude  

      @online = rand(1..100)  
      @onsite =   100 - @online

      if @onsite >= 70  
        url_bike = ActionController::Base.helpers.asset_path('bike.gif')   
        @status = "quente"  
      elsif @onsite <= 20     
        url_bike = ActionController::Base.helpers.asset_path('bike.gif')
        @staus= "frio"
      else  
        url_bike = ActionController::Base.helpers.asset_path('bike.gif')
        @staus= "morno"
      end 

      marker.picture({  
        "url" => url_bike,  
        "width" => 50,  
        "height" => 50  
      })  

      marker.infowindow render_to_string(:partial => "/pages/info",:locals => {:name => plot.name, :pessoas => @pessoas, :date => rand(1.hours.ago..Time.now), :onsite => @onsite, :online => @online })  
  
    end    

  end
  
end
