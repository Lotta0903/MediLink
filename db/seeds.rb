# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# WARNING: DEMO DATA ONLY. Running this script deletes ALL existing users,
# medications and follows before recreating fresh demo records.
# Never run this against a database that holds real user data.

puts "Clearing existing demo data..."
Notification.destroy_all
Medication.destroy_all
Follow.destroy_all
User.destroy_all

puts "Creating users..."
# Alice (68) — grandma. David (42) — her son. Sophie (22) — Alice's granddaughter,
# David's daughter. Marc (65) — Alice's friend. Emma (40) — David's colleague/friend.
# Liam (45) — David's brother, Alice's other son. Nora (55) — Alice's neighbor.
alice  = User.create!(email: "alice@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Alice", last_name: "Miller", photo_url: "https://images.unsplash.com/photo-1719037108848-685e9e599827?w=400")
david  = User.create!(email: "david@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "David", last_name: "Miller", photo_url: "https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200")
sophie = User.create!(email: "sophie@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Sophie", last_name: "Miller", photo_url: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200")
marc   = User.create!(email: "marc@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Marc", last_name: "Dubois", photo_url: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200")
emma   = User.create!(email: "emma@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Emma", last_name: "Chen", photo_url: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400")
liam   = User.create!(email: "liam@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Liam", last_name: "Foster", photo_url: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400")
nora   = User.create!(email: "nora@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Nora", last_name: "Bergman", photo_url: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=400")

puts "Creating medications..."

# Alice — 9 meds, elderly with multiple conditions
alice_aspirin       = alice.medications.create!(name: "Aspirin", dosage: "100mg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 90.days)
alice_levothyroxine = alice.medications.create!(name: "Levothyroxine", dosage: "50mcg", frequency: "Once a day", reminder_time: "06:30", start_date: Date.current, end_date: Date.current + 180.days)
alice_metformin     = alice.medications.create!(name: "Metformin", dosage: "500mg", frequency: "Twice a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 60.days)
alice_atorvastatin  = alice.medications.create!(name: "Atorvastatin", dosage: "20mg", frequency: "Once a day", reminder_time: "21:00", start_date: Date.current, end_date: Date.current + 90.days)
alice_vitamin_d     = alice.medications.create!(name: "Vitamin D", dosage: "1000 IU", frequency: "Once a day", reminder_time: "07:30", start_date: Date.current, end_date: Date.current + 90.days)
alice_calcium       = alice.medications.create!(name: "Calcium", dosage: "500mg", frequency: "Once a day", reminder_time: "12:00", start_date: Date.current, end_date: Date.current + 90.days)
alice_omega3        = alice.medications.create!(name: "Omega-3", dosage: "1000mg", frequency: "Once a day", reminder_time: "13:00", start_date: Date.current, end_date: Date.current + 90.days)
alice_amlodipine    = alice.medications.create!(name: "Amlodipine", dosage: "5mg", frequency: "Once a day", reminder_time: "09:00", start_date: Date.current, end_date: Date.current + 60.days)
alice_lisinopril    = alice.medications.create!(name: "Lisinopril", dosage: "10mg", frequency: "Once a day", reminder_time: "07:00", start_date: Date.current, end_date: Date.current + 60.days)

# David — 5 meds, hypertension + working professional
david_ramipril    = david.medications.create!(name: "Ramipril", dosage: "10mg", frequency: "Once a day", reminder_time: "07:30", start_date: Date.current, end_date: Date.current + 60.days)
david_metformin   = david.medications.create!(name: "Metformin", dosage: "500mg", frequency: "Twice a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 60.days)
david_aspirin     = david.medications.create!(name: "Aspirin", dosage: "81mg", frequency: "Once a day", reminder_time: "09:00", start_date: Date.current, end_date: Date.current + 90.days)
david_vitamin_b12 = david.medications.create!(name: "Vitamin B12", dosage: "1000mcg", frequency: "Once a day", reminder_time: "07:00", start_date: Date.current, end_date: Date.current + 90.days)
david_melatonin   = david.medications.create!(name: "Melatonin", dosage: "3mg", frequency: "Once a day", reminder_time: "22:30", start_date: Date.current, end_date: Date.current + 90.days)

# Sophie — 3 meds, young adult
sophie_contraceptive = sophie.medications.create!(name: "Contraceptive", dosage: "1 pill", frequency: "Once a day", reminder_time: "21:00", start_date: Date.current, end_date: Date.current + 90.days)
sophie_vitamin_c     = sophie.medications.create!(name: "Vitamin C", dosage: "500mg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 90.days)
sophie_iron          = sophie.medications.create!(name: "Iron supplement", dosage: "65mg", frequency: "Once a day", reminder_time: "13:00", start_date: Date.current, end_date: Date.current + 90.days)

# Marc — 5 meds, older man
marc_aspirin     = marc.medications.create!(name: "Aspirin", dosage: "100mg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 90.days)
marc_metformin   = marc.medications.create!(name: "Metformin", dosage: "500mg", frequency: "Twice a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 60.days)
marc_simvastatin = marc.medications.create!(name: "Simvastatin", dosage: "20mg", frequency: "Once a day", reminder_time: "21:00", start_date: Date.current, end_date: Date.current + 90.days)
marc_ibuprofen   = marc.medications.create!(name: "Ibuprofen", dosage: "200mg", frequency: "As needed", reminder_time: "12:00", start_date: Date.current, end_date: Date.current + 14.days)
marc_vitamin_d   = marc.medications.create!(name: "Vitamin D", dosage: "1000 IU", frequency: "Once a day", reminder_time: "07:30", start_date: Date.current, end_date: Date.current + 90.days)

# Emma — 3 meds
emma_sertraline = emma.medications.create!(name: "Sertraline", dosage: "50mg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 90.days)
emma_vitamin_d  = emma.medications.create!(name: "Vitamin D", dosage: "1000 IU", frequency: "Once a day", reminder_time: "09:00", start_date: Date.current, end_date: Date.current + 90.days)
emma_melatonin  = emma.medications.create!(name: "Melatonin", dosage: "3mg", frequency: "Once a day", reminder_time: "22:00", start_date: Date.current, end_date: Date.current + 90.days)

# Liam — 3 meds
liam_atorvastatin = liam.medications.create!(name: "Atorvastatin", dosage: "20mg", frequency: "Once a day", reminder_time: "21:00", start_date: Date.current, end_date: Date.current + 90.days)
liam_vitamin_b12  = liam.medications.create!(name: "Vitamin B12", dosage: "1000mcg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 90.days)
liam_omega3       = liam.medications.create!(name: "Omega-3", dosage: "1000mg", frequency: "Once a day", reminder_time: "13:00", start_date: Date.current, end_date: Date.current + 90.days)

# Nora — 3 meds
nora_levothyroxine = nora.medications.create!(name: "Levothyroxine", dosage: "25mcg", frequency: "Once a day", reminder_time: "06:30", start_date: Date.current, end_date: Date.current + 180.days)
nora_calcium       = nora.medications.create!(name: "Calcium", dosage: "500mg", frequency: "Once a day", reminder_time: "12:00", start_date: Date.current, end_date: Date.current + 90.days)
nora_aspirin       = nora.medications.create!(name: "Aspirin", dosage: "100mg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 90.days)

puts "Marking medications as taken today..."

def taken(medication, at:)
  medication.medication_logs.create!(taken_at: Date.current.beginning_of_day + at)
end

# Alice's morning routine
taken(alice_levothyroxine, at: 6.hours + 35.minutes)
taken(alice_lisinopril,    at: 7.hours + 5.minutes)
taken(alice_vitamin_d,     at: 7.hours + 35.minutes)
taken(alice_aspirin,       at: 8.hours + 10.minutes)
taken(alice_metformin,     at: 8.hours + 15.minutes)

# David
taken(david_vitamin_b12, at: 7.hours)
taken(david_ramipril,    at: 7.hours + 35.minutes)
taken(david_metformin,   at: 8.hours + 5.minutes)
taken(david_aspirin,     at: 9.hours + 15.minutes)

# Sophie
taken(sophie_vitamin_c, at: 8.hours + 10.minutes)

# Marc
taken(marc_aspirin,   at: 8.hours)
taken(marc_vitamin_d, at: 7.hours + 30.minutes)
taken(marc_metformin, at: 8.hours + 20.minutes)

puts "Creating follows..."
# Family and friends keeping an eye on Alice
david.follow(alice)
sophie.follow(alice)
nora.follow(alice)
liam.follow(alice)

# Alice keeps an eye on her friend and granddaughter
alice.follow(marc)
alice.follow(sophie)

# People keeping an eye on David
emma.follow(david)
sophie.follow(david)
david.follow(liam)
david.follow(marc)

puts "Creating notifications..."

def notify(user:, medication:, on:, at:, missed: false)
  Notification.create!(user: user, medication: medication, missed: missed, created_at: on.to_time + at)
end

today        = Date.current
yesterday    = Date.current - 1.day
two_days_ago = Date.current - 2.days

# Alice follows Marc + Sophie
notify(user: alice, medication: marc_aspirin,        on: today, at: 8.hours)
notify(user: alice, medication: sophie_vitamin_c,    on: today, at: 8.hours + 10.minutes)
notify(user: alice, medication: marc_vitamin_d,      on: today, at: 7.hours + 30.minutes)

notify(user: alice, medication: marc_simvastatin,     on: yesterday, at: 21.hours)
notify(user: alice, medication: sophie_contraceptive, on: yesterday, at: 21.hours)
notify(user: alice, medication: marc_metformin,       on: yesterday, at: 20.hours)

notify(user: alice, medication: marc_aspirin,     on: two_days_ago, at: 8.hours)
notify(user: alice, medication: sophie_vitamin_c, on: two_days_ago, at: 8.hours)

# David follows Alice + Liam + Marc — rich feed showing Alice's morning routine
notify(user: david, medication: alice_levothyroxine, on: today, at: 6.hours + 35.minutes)
notify(user: david, medication: alice_lisinopril,    on: today, at: 7.hours + 5.minutes)
notify(user: david, medication: alice_vitamin_d,     on: today, at: 7.hours + 35.minutes)
notify(user: david, medication: alice_aspirin,       on: today, at: 8.hours + 10.minutes)
notify(user: david, medication: alice_metformin,     on: today, at: 8.hours + 15.minutes)
notify(user: david, medication: marc_aspirin,        on: today, at: 8.hours)
notify(user: david, medication: marc_vitamin_d,      on: today, at: 7.hours + 30.minutes)

notify(user: david, medication: alice_levothyroxine, on: yesterday, at: 6.hours + 40.minutes)
notify(user: david, medication: alice_amlodipine,    on: yesterday, at: 9.hours, missed: true)
notify(user: david, medication: liam_atorvastatin,   on: yesterday, at: 21.hours)
notify(user: david, medication: marc_aspirin,        on: yesterday, at: 8.hours)

notify(user: david, medication: alice_metformin,    on: two_days_ago, at: 20.hours)
notify(user: david, medication: liam_vitamin_b12,   on: two_days_ago, at: 8.hours)

puts "Done! Created #{User.count} users, #{Medication.count} medications, #{Follow.count} follows, #{MedicationLog.count} medication_logs, #{Notification.count} notifications."

alice_taken   = alice.medications.select(&:taken_today?).count
alice_pending = alice.medications.count - alice_taken
david_taken   = david.medications.select(&:taken_today?).count
david_pending = david.medications.count - david_taken
david_today_notifs = david.notifications.where(created_at: Date.current.all_day).count

puts "alice@medilink.dev: #{alice_taken} taken today, #{alice_pending} pending (#{alice.medications.count} total meds)"
puts "david@medilink.dev: #{david_taken} taken today, #{david_pending} pending (#{david.medications.count} total meds)"
puts "david@medilink.dev: #{david_today_notifs} notifications from today"

puts "Demo accounts (password: password123): alice@medilink.dev, david@medilink.dev, sophie@medilink.dev, marc@medilink.dev, emma@medilink.dev, liam@medilink.dev, nora@medilink.dev"
