require_dependency 'settings_project_helper_patch.rb'
Redmine::Plugin.register :reviews do
  name 'Reviews plugin'
  author 'Mohamed Maalej - Squeezer software'
  description 'Code review plugin'
  version '0.0.1'
     permission :reviewRequests, { :reviews => [:index] }, :public => true
     permission :receiveRequests, { :reviews => [ :receiveRequests] }, :public => true
     permission :showStats, { :reviews => [ :managerDashboard] }, :public => true
     
    
end
