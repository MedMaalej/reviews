class ReviewsController < ApplicationController
  unloadable


  def isMember(userId,projectId)
     found = Member.where(user_id: userId,project_id: projectId)
     if found == nil
        return false
     end   
     return true
  end  
  def index
     req = params['req'].blank? ? '' : params['req']
     @projName = params['project_id']
        
     
  end
  def availableBranches
     req = params['req'].blank? ? '' : params['req']
     @projName = params['project_id']

     if req.eql?  '1'
        @req = 1
        puts "in"
        @projName = params['projectName']
        proj = Project.where(name: @projName).pluck("id")
        puts proj
        url = Repository.where(project_id: proj).pluck("url")

        if url != nil
           str = url.join('')
           str =str[0..str.length-6]
           #puts str
           system "cd "+str + "&& git pull origin master "
           system "cd "+str + "&& git branch > branches.txt "
           @repo = str
           @allUsers = User.all     
           
           
        end

    end

    # @projName = params['project_id']
    # proj = Project.where(name: @projName).pluck("id")
    # @url = Repository.where(project_id: proj).pluck("url")
        
       
  end
  def requestConfirmed () 
     uName = params["reviewer"].split(" ")
     #retrieving project's id
     @projName = params['projectName']
     reviewer = User.where(firstname: uName[0],lastname: uName[1]).pluck("id")
     r  = Review.new
     r.status = "request";
     r.decision = "pending";
     r.reviewerId = reviewer;
     r.status = "request"
     r.decision = "pending"
     r.reviewerId = reviewer[0]
     r.userId = User.current.id
     time1 = Time.new
     r.dater = time1.inspect
     r.comment = "No comments"
     r.score = 1
     r.sprintId = 15
     proj  = Project.where(name: @projName).pluck("id")
     url = Repository.where(project_id: proj).pluck("url")
     str = url.join('')
     str =str[0..str.length-6]
     r.branchName =str+";branch:"+params["branch"]
     r.projectId = proj[0]
     r.save

  end  
end
