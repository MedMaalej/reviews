require_dependency 'settings_project_helper_patch.rb'
Redmine::Plugin.register :reviews do
  name 'Reviews plugin'
  author 'Mohamed Maalej - Squeezer software'
  description 'Code review plugin'
  version '0.0.1'
  project_module :reviews do
     permission :send_review_requests,  :reviews => :index, :require => :member
     permission :receive_review_requests, :reviews => :receiveRequests, :require => :member
     permission :show_reviews_statistics,  :reviews => :managerDashboard, :require => :member
     permission :manage_project_workflow, {}, :require => :member
     permission :manage_repository, {}, :require => :member
     permission :browse_repository, {}, :require => :member
  end   
    
end
