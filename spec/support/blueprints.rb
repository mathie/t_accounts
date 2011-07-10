require 'machinist/active_record'

Machinist.configure do |config|
  config.cache_objects = false
end

Worksheet.blueprint do
  name { "Worksheet #{sn}" }
  narrative do
    <<-TEXT
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    TEXT
  end

  user
end

Account.blueprint do
  name { "Account #{sn}" }

  # Code is three digits.
  code { sn.last(3) }
end

Transaction.blueprint do
  # Attributes here
end

User.blueprint do
  email                 { "joe.bloggs+#{sn}@example.com" }
  password              { "password" }
  password_confirmation { "password" }
end
