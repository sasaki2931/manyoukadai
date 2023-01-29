


User.create!(name:"test10", email:"test18@test.com",password:"testtest10", password_confirmation: "testtest10",admin:true,id:"20")

10.times do |n|
    User.create!(
      name: "test#{ n+1}",
      email: "test#{ n+1}@test.com",
      password: "testetst#{ n+1}",
      password_confirmation: "testetst#{ n+1}"
      )
end

10.times do |n|
    Task.create!(
      user_id: "#{ n+1}",
      name: "aa#{ n+1}",
      content: "aa#{ n+1}",
      deadline: "2011-01-01"
      )
end


10.times do |n|
    Label.create!(
        name: "#{ n+1}",
        id: "#{ n+1}"
    )
end