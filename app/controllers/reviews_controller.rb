class ReviewsController < ApplicationController
  unloadable



  def index
     req = params['req'].blank? ? '' : params['req']
     puts params['project_id']
     @projName = params['project_id']
     if req.eql?  '1'
        puts "in"
        projectName = params['projectName']
        proj = Project.where(name: projectName).pluck("id")
        url = Repository.where(project_id: proj).pluck("url")
        puts url
        if url != nil  
           str = url.join('')
           str =str[0..str.length-6]
           puts str
           system "cd "+str + "&& git branch > branches.txt "
           @repo = str
           redirect_to :back 
           
        end   
    end
  end
  
end
