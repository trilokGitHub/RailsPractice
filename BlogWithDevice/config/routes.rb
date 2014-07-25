NewBlog::Application.routes.draw do

  devise_for :users
  root to: 'articles#index'

  get 'articles', to: 'articles#index', as: :articles
  post 'articles', to: 'articles#create'

  get 'articles/new', to: 'articles#new', as: :new_article
  get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  get 'articles/:id', to: 'articles#show', as: :article

  patch 'articles/:id', to: 'articles#update'
  put 'articles/:id', to: 'articles#update'
  delete 'articles/:id', to: 'articles#destroy', as: :destroy_article

  # for comments in article

  get    '/articles/:article_id/comments', to: 'comments#index', as: :article_comments
  post   '/articles/:article_id/comments', to: 'comments#create'

  get    '/articles/:article_id/comments/new', to: 'comments#new', as: :new_article_comment
  get    '/articles/:article_id/comments/:id/edit', to: 'comments#edit', as: :edit_article_comment
  get    '/articles/:article_id/comments/:id', to: 'comments#show', as: :article_comment

  patch  '/articles/:article_id/comments/:id', to: 'comments#update'
  put    '/articles/:article_id/comments/:id', to: 'comments#update'
  delete '/articles/:article_id/comments/:id', to: 'comments#destroy', as: :destroy_comment

  get '/articles/:id/analysis',to: 'articles#analysis'

end
