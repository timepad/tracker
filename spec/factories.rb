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

  factory :story_point do
    title 'Some cool stuff'
    
    user_github_login 'john'
    
    user_github_avatar_url 'https://avatars.githubusercontent.com/u/0'
    
    story_point_size 'M'
    
    github_closed_at DateTime.new 2014, 01, 01
    
    github_merged_at DateTime.new 2014, 01, 01
    
    story_point_type 'new'
    
    github_html_url 'https://github.com/someorg/someproject/pull/1'
    
    project
  end
end
