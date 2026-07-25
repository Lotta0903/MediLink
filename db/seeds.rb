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
alice  = User.create!(email: "alice@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Alice", last_name: "Miller", photo_url: "https://randomuser.me/api/portraits/women/90.jpg")
david  = User.create!(email: "david@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "David", last_name: "Miller", photo_url: "https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200")
sophie = User.create!(email: "sophie@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Sophie", last_name: "Miller", photo_url: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200")
marc   = User.create!(email: "marc@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Marc", last_name: "Dubois", photo_url: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200")
emma   = User.create!(email: "emma@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Emma", last_name: "Chen", photo_url: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400")
liam   = User.create!(email: "liam@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Liam", last_name: "Foster", photo_url: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400")
nora   = User.create!(email: "nora@medilink.dev", password: "password123", password_confirmation: "password123", first_name: "Nora", last_name: "Bergman", photo_url: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=400")

puts "Creating medications..."

alice_aspirin       = alice.medications.create!(name: "Aspirin", dosage: "500mg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 30.days)
alice_ibuprofen     = alice.medications.create!(name: "Ibuprofen", dosage: "200mg", frequency: "Twice a day", reminder_time: "09:00", start_date: Date.current, end_date: Date.current + 14.days)
alice_vitamin_d     = alice.medications.create!(name: "Vitamin D", dosage: "1000 IU", frequency: "Once a day", reminder_time: "07:30", start_date: Date.current, end_date: Date.current + 90.days)
alice_levothyroxine = alice.medications.create!(name: "Levothyroxine", dosage: "50mcg", frequency: "Once a day", reminder_time: "06:30", start_date: Date.current, end_date: Date.current + 180.days)
alice_metformin     = alice.medications.create!(name: "Metformin", dosage: "500mg", frequency: "Twice a day", reminder_time: "12:00", start_date: Date.current, end_date: Date.current + 60.days)
alice_atorvastatin  = alice.medications.create!(name: "Atorvastatin", dosage: "20mg", frequency: "Once a day", reminder_time: "21:00", start_date: Date.current, end_date: Date.current + 90.days)
alice_omega3        = alice.medications.create!(name: "Omega-3", dosage: "1000mg", frequency: "Once a day", reminder_time: "13:00", start_date: Date.current, end_date: Date.current + 90.days)
alice_calcium       = alice.medications.create!(name: "Calcium", dosage: "500mg", frequency: "Once a day", reminder_time: "14:00", start_date: Date.current, end_date: Date.current + 90.days)
alice_b12           = alice.medications.create!(name: "B12", dosage: "1000mcg", frequency: "Once a day", reminder_time: "08:30", start_date: Date.current, end_date: Date.current + 90.days)

david_metformin  = david.medications.create!(name: "Metformin", dosage: "500mg", frequency: "Twice a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 60.days)
david_lisinopril = david.medications.create!(name: "Lisinopril", dosage: "10mg", frequency: "Once a day", reminder_time: "20:00", start_date: Date.current, end_date: Date.current + 60.days)
david_omeprazole = david.medications.create!(name: "Omeprazole", dosage: "20mg", frequency: "Once a day", reminder_time: "07:00", start_date: Date.current, end_date: Date.current + 21.days)
david_vitamin_b12 = david.medications.create!(name: "Vitamin B12", dosage: "1000mcg", frequency: "Once a day", reminder_time: "09:00", start_date: Date.current, end_date: Date.current + 90.days)
david_omega3     = david.medications.create!(name: "Omega-3", dosage: "1000mg", frequency: "Once a day", reminder_time: "13:00", start_date: Date.current, end_date: Date.current + 90.days)

sophie_contraceptive = sophie.medications.create!(name: "Contraceptive", dosage: "1 pill", frequency: "Once a day", reminder_time: "21:00", start_date: Date.current, end_date: Date.current + 90.days)
sophie_vitamin_c     = sophie.medications.create!(name: "Vitamin C", dosage: "500mg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 90.days)
sophie_zinc          = sophie.medications.create!(name: "Zinc", dosage: "15mg", frequency: "Once a day", reminder_time: "20:00", start_date: Date.current, end_date: Date.current + 90.days)
sophie_magnesium     = sophie.medications.create!(name: "Magnesium", dosage: "300mg", frequency: "Once a day", reminder_time: "21:30", start_date: Date.current, end_date: Date.current + 90.days)

marc_aspirin       = marc.medications.create!(name: "Aspirin", dosage: "500mg", frequency: "Once a day", reminder_time: "08:30", start_date: Date.current, end_date: Date.current + 30.days)
marc_metformin     = marc.medications.create!(name: "Metformin", dosage: "500mg", frequency: "Twice a day", reminder_time: "12:00", start_date: Date.current, end_date: Date.current + 60.days)
marc_ibuprofen     = marc.medications.create!(name: "Ibuprofen", dosage: "200mg", frequency: "Twice a day", reminder_time: "09:00", start_date: Date.current, end_date: Date.current + 14.days)
marc_insulin       = marc.medications.create!(name: "Insulin", dosage: "10 units", frequency: "Twice a day", reminder_time: "07:00", start_date: Date.current, end_date: Date.current + 365.days)
marc_levothyroxine = marc.medications.create!(name: "Levothyroxine", dosage: "50mcg", frequency: "Once a day", reminder_time: "07:00", start_date: Date.current, end_date: Date.current + 180.days)

emma_sertraline = emma.medications.create!(name: "Sertraline", dosage: "50mg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 90.days)
emma_vitamin_d  = emma.medications.create!(name: "Vitamin D", dosage: "1000 IU", frequency: "Once a day", reminder_time: "09:00", start_date: Date.current, end_date: Date.current + 90.days)
emma_iron       = emma.medications.create!(name: "Iron", dosage: "65mg", frequency: "Once a day", reminder_time: "19:00", start_date: Date.current, end_date: Date.current + 90.days)
emma_omega3     = emma.medications.create!(name: "Omega-3", dosage: "1000mg", frequency: "Once a day", reminder_time: "20:00", start_date: Date.current, end_date: Date.current + 90.days)

liam_amlodipine   = liam.medications.create!(name: "Amlodipine", dosage: "5mg", frequency: "Once a day", reminder_time: "07:00", start_date: Date.current, end_date: Date.current + 60.days)
liam_aspirin      = liam.medications.create!(name: "Aspirin", dosage: "500mg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 30.days)
liam_atorvastatin = liam.medications.create!(name: "Atorvastatin", dosage: "20mg", frequency: "Once a day", reminder_time: "21:00", start_date: Date.current, end_date: Date.current + 90.days)

nora_levothyroxine = nora.medications.create!(name: "Levothyroxine", dosage: "50mcg", frequency: "Once a day", reminder_time: "07:00", start_date: Date.current, end_date: Date.current + 180.days)
nora_vitamin_d     = nora.medications.create!(name: "Vitamin D", dosage: "1000 IU", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 90.days)
nora_calcium       = nora.medications.create!(name: "Calcium", dosage: "500mg", frequency: "Once a day", reminder_time: "20:00", start_date: Date.current, end_date: Date.current + 90.days)

puts "Marking some of Alice's medications as taken today..."
alice_aspirin.medication_logs.create!(taken_at: Date.current.beginning_of_day + 8.hours + 15.minutes)
alice_vitamin_d.medication_logs.create!(taken_at: Date.current.beginning_of_day + 7.hours + 35.minutes)
alice_levothyroxine.medication_logs.create!(taken_at: Date.current.beginning_of_day + 6.hours + 45.minutes)
alice_b12.medication_logs.create!(taken_at: Date.current.beginning_of_day + 8.hours + 40.minutes)

puts "Creating follows..."
david.follow(alice)
sophie.follow(alice)
emma.follow(alice)
liam.follow(alice)
nora.follow(alice)
alice.follow(marc)
alice.follow(emma)
alice.follow(nora)

puts "Creating notifications..."

def notify(user:, medication:, on:, at:, missed: false)
  Notification.create!(user: user, medication: medication, missed: missed, created_at: on.to_time + at)
end

today        = Date.current
yesterday    = Date.current - 1.day
two_days_ago = Date.current - 2.days

notify(user: alice, medication: david_metformin,  on: today, at: 9.hours + 15.minutes)
notify(user: alice, medication: sophie_vitamin_c, on: today, at: 8.hours)
notify(user: alice, medication: marc_aspirin,     on: today, at: 8.hours + 30.minutes)
notify(user: alice, medication: emma_vitamin_d,   on: today, at: 9.hours)
notify(user: alice, medication: nora_vitamin_d,   on: today, at: 8.hours)

notify(user: alice, medication: david_lisinopril,     on: yesterday, at: 7.hours)
notify(user: alice, medication: sophie_contraceptive, on: yesterday, at: 21.hours)
notify(user: alice, medication: marc_metformin,       on: yesterday, at: 12.hours)
notify(user: alice, medication: emma_sertraline,      on: yesterday, at: 8.hours)
notify(user: alice, medication: nora_levothyroxine,   on: yesterday, at: 7.hours)

notify(user: alice, medication: david_omeprazole, on: two_days_ago, at: 7.hours)
notify(user: alice, medication: sophie_vitamin_c, on: two_days_ago, at: 8.hours)
notify(user: alice, medication: marc_ibuprofen,   on: two_days_ago, at: 9.hours)
notify(user: alice, medication: emma_iron,        on: two_days_ago, at: 19.hours)
notify(user: alice, medication: nora_calcium,     on: two_days_ago, at: 20.hours)

puts "Done! Created #{User.count} users, #{Medication.count} medications, #{Follow.count} follows, #{Notification.count} notifications."
puts "Demo accounts (password: password123): alice@medilink.dev, david@medilink.dev, sophie@medilink.dev, marc@medilink.dev, emma@medilink.dev, liam@medilink.dev, nora@medilink.dev"
