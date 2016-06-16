require 'active_record'
require 'mysql2'

module CCULProjectsHelperPatch
  def self.included(base)
  base.send(:include, ProjectsHelperMethodsCCUL)

  base.class_eval do
    unloadable
    alias_method_chain :project_settings_tabs, :reviews
  end
 end
end

module ProjectsHelperMethodsCCUL
  
  def project_settings_tabs_with_reviews
#Rails.configuration.to_prepare do
           @tabs = project_settings_tabs_without_reviews
           @action = {:name => 'Code_reviews', :partial => 'tab/codeReviews', :label => :code_review}	
           Rails.logger.info "old_tabs: #{@tabs}"
           Rails.logger.info "action: #{@action}"
           @tabs << @action #if User.current.allowed_to?(action, @project)
           @tabs
  end
end
ProjectsHelper.send(:include, CCULProjectsHelperPatch) unless ProjectsHelper.included_modules.include? CCULProjectsHelperPatch
