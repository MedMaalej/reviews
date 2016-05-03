Redmine::Plugin.register :reviews do
  name 'Reviews plugin'
  author 'Mohamed Maalej - Squeezer software'
  description 'Code review plugin'
  version '0.0.1'
  permission :reviews, { :reviews => [:index] }, :public => true
  permission :incomingReq, { :reviews => [:receiveRequests] }, :public => true
  menu :project_menu, :reviews, { :controller => 'reviews', :action => 'index' }, :caption => 'Reviews', :after => :activity, :param => :project_id
  menu :project_menu, :incomingRequests, { :controller => 'reviews', :action => 'receiveRequests' }, :caption => 'Incoming review requests', :after => :reviews , :param => :project_id
end
