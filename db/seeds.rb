User.create!(name:"test", email:"test@test.com",password:"testtest", password_confirmation: "testtest",admin:false)

5.times do |n|
    Label.create!(
        name:"#{ n+1}"
    )
end