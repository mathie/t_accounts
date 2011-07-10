# T Accounts

I'm learning accounting, and as I was working through some examples, I thought
to myself, "what better way to learn this properly than code it up with some
examples?" So that's what I'm doing. I'm sure this codebase will change as I
move through the course, but right now I'm looking to create T accounts from a
set of transactions, and use them to extract a trial balance.

For bonus points, it's been a while since I've been on anything beyond the
trailing edge of Rails, so I thought I'd use it as an excuse to learn what's
new. :)

## Getting started with the code

1. Grab the repository from GitHub: <https://github.com/mathie/t_accounts>

2. Get into a terminal and switch to the directory you checked out the code
   into.

3. Install dependencies with bundler: `bundle install`

4. Create the relevant databases: `bundle exec rake db:create:all`

5. Load the schema and seed data into your development database:
   `bundle exec rake db:reset`

6. Run the test suite (optional): `bundle exec rake`

7. Run the server: `bundle exec foreman start`

## Disclaimer

I work for FreeAgent Central, a Software-as-a-Service accounting app. This
code doesn't intend to bear any resemblance to the FreeAgent code (though it
might wind up being a bit of a playground while I try out some new ideas!). :)
