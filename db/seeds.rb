User.new(name: "star",
            display_name: "Star Butterfly",
            email: "star@example.com",
            password: "password").save!

10.times do |n|
  display_name = Faker::FamilyGuy.unique.character
  name = display_name.split(' ')[0].downcase
  email = "#{name}@example.com"
  password = "password"
  User.new(name: name,
              display_name: display_name,
              email: email,
              password: password).save!
end
