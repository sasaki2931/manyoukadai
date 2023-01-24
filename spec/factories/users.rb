FactoryBot.define do
  factory :user do
    name { "test" }
    email { "test@test.com" }
    password { 'testtest' }
    password_confirmation {'testtest' }
    admin {"false"}
  end

  factory :user2, class: User do
    name {"test2"}
    email{"test2@test.com"}
    password { 'test2test2' }
    password_confirmation { 'test2test2' }
    admin{"true"}
  end
end
