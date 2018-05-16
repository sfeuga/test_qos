# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sensors do
    resources :values
  end
end
