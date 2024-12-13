User.create!(
  email_address: 'guest@example.com',
  password: 'password',
  role: 'guest',
  first_name: 'Guest',
  last_name: 'User'
)

Payment.create!(
  payment_method: 'credit_card',
  amount: 100.00,
  status: true
)

User.create!(email_address: 'guest@example.com', password: 'password', role: 'guest')
User.create!(email_address: 'admin@example.com', password: 'password', role: 'admin')

Event.create!(title: 'Test Event 1', date: 2.days.from_now, creator: User.first)
Event.create!(title: 'Test Event 2', date: 1.week.from_now, creator: User.last)

Payment.create!(payment_method: 'credit_card', amount: 100.00, status: true)
