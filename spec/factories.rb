FactoryGirl.define do
  factory :user do
    sequence(:email){ |n| "user_numero_#{ n }@mail.com" }
    name 'all_users_have_the_same_name'
    password 'all_users_have_the_same_password'
  end

  factory :request do
    sequence(:title){ |n| "request_title_#{ n }" }

    content 'Can you release this cool stuff?'

    user

    project
  end

  factory :project do
    sequence(:github_path){ |n| "project_#{ n }/name" }
  end
end
