class ReviewsController < ApplicationController
  unloadable



  def index
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
           
                     
        end
       
    end
  end
  
end
