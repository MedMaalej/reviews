Redmine::Plugin.register :reviews do
  name 'Reviews plugin'
  author 'Mohamed Maalej - Squeezer software'
  description 'Code review plugin'
  version '0.0.1'
  permission :reviews, { :reviews => [:index] }, :public => true
  menu :project_menu, :reviews, { :controller => 'reviews', :action => 'index' }, :caption => 'Reviews', :after => :activity, :param => :project_id

end
