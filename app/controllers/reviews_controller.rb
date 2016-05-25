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
     @project = Project.find(params[:project_id])
     tr = Tracker.find_by(name: 'Code review')
     if tr == nil
        t  = Tracker.new
        t.name="Code review"
        t.is_in_chlog = 1
        t.position = 4
        t.is_in_roadmap = 1
        t.fields_bits = 0
        t.default_status_id = 1
        t.save 
     end
     req = params['req'].blank? ? '' : params['req']
     @projName = params['project_id']
     proj = Project.where(name: @projName).pluck("id")
     @reviews = Review.where(userId: User.current.id , projectId: proj)                  
  end
  def availableBranches
     
     req = params['req'].blank? ? '' : params['req']
     @projName = params['project_id']
     @project = Project.find(params[:project_id])
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
           users = []
           i =0
           allU = User.all
           allU.each do  |user|
              if isMember(user.id, proj[0])
                 users [i] = user
                 i = i + 1
              end
           end
           @allUsers = allU
           
           
           
           
        end

    end

    # @projName = params['project_id']
    # proj = Project.where(name: @projName).pluck("id")
    # @url = Repository.where(project_id: proj).pluck("url")
        
       
  end
  def requestConfirmed () 
     @project = Project.find(params[:project_id])
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
     r.score = -1
     r.sprintId = 15
     proj  = Project.where(name: @projName).pluck("id")
     url = Repository.where(project_id: proj).pluck("url")
     str = url.join('')
     str =str[0..str.length-6]
     r.branchName =str+";"+params["branch"]
     r.projectId = proj[0]
     r.save
     
  end  
  def receiveRequests()
     @project = Project.find(params[:project_id])
     tr = Tracker.find_by(name: 'Code review')
     if tr == nil
        t  = Tracker.new
        t.name="Code review"
        t.is_in_chlog = 1
        t.position = 4
        t.is_in_roadmap = 1
        t.fields_bits = 0
        t.default_status_id = 1
        t.save
     end
     #projId = (Project.find_by(name: params['project_id']))['id']
     @incomingRequests = Review.where(reviewerId: User.current.id , status: 'request')
     @acceptedIncomingRequests = Review.where(reviewerId: User.current.id , status: ['accepted','in review'])
     
     acc = params['rAccept']
     if acc.eql?  '1' 
        r = Review.find_by(id: params['currentReview'])
        r.update(status: 'accepted')       
        @accepted = 1
        #redirect_to :receiveRequests
     end
     
  end
  def codeReview()     
     @project = Project.find(params[:project_id])
     @projName = params['project_id']
     start = params['rStart']
     if start.eql? '1' 
        rev = params['reviewId']
        status = Review.where(id: rev).pluck("status")[0]
        puts rev
        @projName = params['projectName']
        proj = Project.where(name: @projName).pluck("id")
        url = Repository.where(project_id: proj).pluck("url")
        if status.eql? 'accepted' 
           if url != nil
              str = url.join('')
              str =str[0..str.length-6]
              puts str
              proj = params['projectName']
              system "cd "+str + "&& git pull origin master"
              time = Time.new               
              system "cd "+str + "&& git checkout -b "+ proj +"_review_"+time.day.to_s+"-"+time.month.to_s+"-"+time.year.to_s+"-"+
              time.hour.to_s+"_"+time.min.to_s+"_"+time.sec.to_s
              r = Review.find_by(id: params['reviewId'])
              r.update(status: 'in review')
              r.update(branchName: str+";"+proj +"_review_"+time.day.to_s+"-"+time.month.to_s+"-"+time.year.to_s+"-"+
              time.hour.to_s+"_"+time.min.to_s+"_"+time.sec.to_s)
              session[:rId] = r['id']
              redirect_to '/projects/' +@projName+'/repository' 
           end 
        elsif status.eql? 'in review' 
           branch = params['branch']
           puts branch+".........."
           if url != nil
              str = url.join('')
              str =str[0..str.length-6]
              puts str
              proj = params['projectName']
              br = branch.split(";") 
              system "cd "+str + "&& git checkout  "+ br[1]
              r = Review.find_by(id: params['reviewId'])
              session[:rId] = r['id']
              redirect_to '/projects/' +@projName+'/repository'
           end              
       else
       end
     end
  end
  def doCommentLine
     @project = Project.find(params[:project_id])
     if(params['scored'].eql? '1')
        
        review = Review.find_by(id: session[:rId])
        review.update(score: params['score'].to_i)
        session[:lastScore] = params['score'].to_i
        if(params['score'].to_i == 5)
             review.update(status: 'validated')
        end
        #puts "Yessssssssss"
        redirect_to :back
        return
     end
     patch = Patch.new
     patch.pComment = params['comment']
     patch.pLine = params['lineNbr']
     patch.pErrorId = Error.where(errorName: params['errors']).pluck('id')[0]
     patch.ptime = Time.now.to_s
     patch.reviewId = session[:rId]
     projId = (Project.find_by(name: params[:project_id]))['id']
     developerId = (Review.find_by(id: session[:rId]))['userId']
     sql = "Select id from trackers where name='Code review';"
     #track = ActiveRecord::Base.connection.execute(sql)         
     issue = Issue.new(:project_id => projId, :tracker_id => 2, :author_id => User.current.id, :subject => 'code_review_'+session[:rId].to_s, :assigned_to_id => developerId, :description => (patch.pLine).to_s+':'+patch.pComment)
     issue.save
     patch.issueId = issue.id           
     patch.pFileName = session[:path]
     patch.save     
     redirect_to :back
  end
  def getReviewByBranchName(branch)
     rev = Review.where(branchName: branch).pluck('id')
     return rev[0]
  end 
  
 
end
