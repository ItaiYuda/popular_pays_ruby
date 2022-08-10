Rails.application.routes.draw do
  resources :gig_payments do
    put 'set_complete', :on => :member
  end
  resources :gigs do
    put 'set_complete', :on => :member
  end
  resources :creators

  match '*path', :to => 'application#routing_error', via: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# :on => :collection
# <resource_name>/<method_name>
# ex. GET gigs/search
# :on => :member
# <resource_name>/:id/<method_name>
# ex. PUT gigs/:id/set_complete
