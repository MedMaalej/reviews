Redmine::Plugin.register :reviews do
  name 'Reviews plugin'
  author 'Mohamed Maalej - Squeezer software'
  description 'Code review plugin'
  version '0.0.1'
  
  project_module :reviews do     
     permission :Send_review_requests,  :reviews => :index 
     permission :Receive_requests,  :reviews => :receiveRequests
      permission :Show_stats,  :reviews => :managerDashboard
     menu :project_menu, :reviewRequests, { :controller => 'reviews', :action => 'index' }, :caption => 'Make review requests',
      :after => :activity,  :param => :project_id
     menu :project_menu, :receiveRequests, { :controller => 'reviews', :action => 'receiveRequests' }, :caption => 'Incoming review requests', 
     :after => :reviewRequests , :param => :project_id
      
     menu :project_menu, :showStats, { :controller => 'reviews', :action => 'managerDashboard' }, :caption => 'Code review stats',
     :after => :reviewRequests , :param => :project_id
  end
end
