Redmine::Plugin.register :reviews do
  name 'Reviews plugin'
  author 'Mohamed Maalej - Squeezer software'
  description 'Code review plugin'
  version '0.0.1'
  permission :reviewRequests, { :reviews => [:index] }, :public => true
  permission :receiveRequests, { :reviews => [:receiveRequests] }, :public => true
  menu :project_menu, :reviewRequests, { :controller => 'reviews', :action => 'index' }, :caption => 'Make review requests', :after => :activity, :param => :project_id
  menu :project_menu, :receiveRequests, { :controller => 'reviews', :action => 'receiveRequests' }, :caption => 'Incoming review requests', :after => :reviewRequests , :param => :project_id
end
