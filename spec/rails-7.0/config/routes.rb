QueryDietSpecApp::Application.routes.draw do
  get '/query_diet/no_query', to: 'query_diet#no_query'
  get '/query_diet/two_queries', to: 'query_diet#two_queries'
end
