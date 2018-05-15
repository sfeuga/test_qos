# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sensor do
    resources :values
  end
end
