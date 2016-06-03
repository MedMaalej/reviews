# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'reviews', :to => 'reviews#index'
get 'availableBranches', :to => 'reviews#availableBranches'
get 'requestConfirmed' , :to => 'reviews#requestConfirmed'
get 'receiveRequests' , :to => 'reviews#receiveRequests'
get 'codeReview' , :to => 'reviews#codeReview'
get 'doCommentLine' , :to => 'reviews#doCommentLine'
get 'managerDashboard' , :to => 'reviews#managerDashboard'
get 'confirmCorrections' , :to => 'reviews#confirmCorrections'
