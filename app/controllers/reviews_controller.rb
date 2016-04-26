class ReviewsController < ApplicationController
  unloadable



  def index
     allUsers = User.all     
     words = ''
     allUsers.each do |user|
        if user['firstname'] != '' && user['lastname'] != ''
           val = user['firstname'] || ' ' ||  user['lastname']  
           words = words + val +","
        end
     end
     words = words[0..words.length-2]
     @retNames = words 
     puts @retNames               
  end

end
