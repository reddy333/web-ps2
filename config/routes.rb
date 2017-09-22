Rails.application.routes.draw do
  get 'basics/quotations'
  get 'basics/fetch'

  root :to => "basics#quotations"
  root :to  => "basics#quotations"
  root :to => "basics#quotations.json"
  post 'basics/quotations'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
