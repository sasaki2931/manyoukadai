FactoryBot.define do
  factory :user do
    name { "user1" }
    email { "user1@gmail.com" }
    password { 'user1@gmail.com' }
    password_confirmation { 'user1@gmail.com' }
    admin {"false"}
  end

  factory :top_user, class: User do
    name {"top_user"}
    email{"top_user@gmail.com"}
    password { 'top_user@gmail.com' }
    password_confirmation { 'top_user@gmail.com' }
    admin{"true"}
  end
end
