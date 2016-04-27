class ReviewsController < ApplicationController
  unloadable



  def index
     allUsers = User.all     
     words = ''
     allUsers.each do |user|
        if user['firstname'] != '' && user['lastname'] != ''
           val = user['firstname'] + '_' +  user['lastname']  
           words = words + val +","
        end
     end
     words = words[0..words.length-2]
     @retNames = words 
     @projects = Project.all.pluck("name")
     req = params['req'].blank? ? '' : params['req']      
     puts "req="+req
     if req.eql?  '1'
        @requestOn = true
        puts "in"
        projectName = params["projectName"]
        proj = Project.where(name: projectName).pluck("id")
        
        reviewerName = params["reviewerName"]
        
        url = Repository.where(project_id: proj).pluck("url")
        
        puts url
        if url != nil  
           str = url.join('')
           str =str[0..str.length-6]
           #puts str
           system "cd "+str + "&& git checkout -b "+projectName+"_code_review"
        end   
        @projects = Project.all.pluck("name")  
        @reviews = Review.where(userId: User.current.id)
        uName = reviewerName.split("_")
        reviewer = User.where(firstname: uName[0],lastname: uName[1]).pluck("id")
        r  = Review.new
        r.status = "request"
        r.decision = "pending"
        r.reviewerId = reviewer[0]
        puts reviewer      
        r.userId = User.current.id
        time1 = Time.new
        r.dater = time1.inspect
        r.comment = "No comments"
        r.score = 1 
        r.sprintId = 15 
        r.save
      end
  end
  
end
