# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sensor do
    resources :value
  end
end
