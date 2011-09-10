# Create a default user so I don't have to keep signing up...
unless User.exists?(email: 'mathie@woss.name')
  user = User.new email: 'mathie@woss.name',
    password:              'password',
    password_confirmation: 'password',
    name:                  'Graeme Mathieson'
  user.confirmed_at = Time.now
  user.save!

  20.times do
    worksheet = user.worksheets.create! name: Faker::Company.bs, narrative: Faker::Lorem.paragraphs.join("\n\n")

    # Create a few accounts
    accounts = []
    rand(10).times do
      accounts << worksheet.accounts.create!(name: Faker::Company.bs)
    end

    # Create a bunch of transactions
    date_range = ((Date.today - 1.year)..Date.today).to_a
    rand(100).times do
      worksheet.transactions.create! dated_on: date_range.sample,
        description:       Faker::Company.bs,
        debit_account_id:  accounts.sample.id,
        credit_account_id: accounts.sample.id,
        amount:            BigDecimal(rand(10_000).to_s) / BigDecimal('100')
    end
  end
end
