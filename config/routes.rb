# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products

  namespace :admin do
    resources :products
  end
end
