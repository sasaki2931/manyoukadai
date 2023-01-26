User.create!(name:"test", email:"test@test.com",password:"testtest", password_confirmation: "testtest",admin:false)
User.create!(name:"test2", email:"test2@test.com",password:"testtest2", password_confirmation: "testtest2",admin:true)
5.times do |n|
    Label.create!(
        name:"#{ n+1}"
    )
end