# Create a default user so I don't have to keep signing up...
unless User.exists?(email: 'mathie@woss.name')
  user = User.new email: 'mathie@woss.name',
    password:              'password',
    password_confirmation: 'password',
    name:                  'Graeme Mathieson'
  user.confirmed_at = Time.now
  user.save!

  20.times do
    user.worksheets.create! name: Faker::Company.bs, narrative: Faker::Lorem.paragraphs.join("\n\n")
  end
end
