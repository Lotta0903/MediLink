# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# WARNING: DEMO DATA ONLY. Running this script deletes ALL existing users,
# family members and medications before recreating fresh demo records.
# Never run this against a database that holds real user data.

puts "Clearing existing demo data..."
Medication.destroy_all
FamilyMember.destroy_all
User.destroy_all

puts "Creating users..."
alice = User.create!(email: "alice@medilink.dev", password: "password123", password_confirmation: "password123")
bob   = User.create!(email: "bob@medilink.dev", password: "password123", password_confirmation: "password123")
carla = User.create!(email: "carla@medilink.dev", password: "password123", password_confirmation: "password123")

puts "Creating family members..."
tom   = alice.family_members.create!(first_name: "Tom", last_name: "Dupont", status: "active")
lucie = alice.family_members.create!(first_name: "Lucie", last_name: "Dupont", status: "active")
marc  = alice.family_members.create!(first_name: "Marc", last_name: "Dupont", status: "active")

def create_medications(owner, medications)
  medications.each { |attrs| owner.medications.create!(attrs) }
end

puts "Creating medications..."

create_medications(alice, [
  { name: "Aspirin", dosage: "500mg", frequency: "Once a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 30.days },
  { name: "Ibuprofen", dosage: "200mg", frequency: "Twice a day", reminder_time: "09:00", start_date: Date.current, end_date: Date.current + 14.days },
  { name: "Vitamin D", dosage: "1000 IU", frequency: "Once a day", reminder_time: "07:30", start_date: Date.current, end_date: Date.current + 90.days },
])

create_medications(bob, [
  { name: "Metformin", dosage: "500mg", frequency: "Twice a day", reminder_time: "08:00", start_date: Date.current, end_date: Date.current + 60.days },
  { name: "Lisinopril", dosage: "10mg", frequency: "Once a day", reminder_time: "20:00", start_date: Date.current, end_date: Date.current + 60.days },
])

create_medications(carla, [
  { name: "Omeprazole", dosage: "20mg", frequency: "Once a day", reminder_time: "07:00", start_date: Date.current, end_date: Date.current + 21.days },
  { name: "Paracetamol", dosage: "500mg", frequency: "As needed", reminder_time: "12:30", start_date: Date.current, end_date: Date.current + 7.days },
  { name: "Amoxicillin", dosage: "250mg", frequency: "Three times a day", reminder_time: "18:00", start_date: Date.current, end_date: Date.current + 10.days },
])

create_medications(tom, [
  { name: "Amoxicillin", dosage: "250mg", frequency: "Three times a day", reminder_time: "07:00", start_date: Date.current, end_date: Date.current + 10.days },
  { name: "Paracetamol", dosage: "250mg", frequency: "As needed", reminder_time: "13:00", start_date: Date.current, end_date: Date.current + 7.days },
])

create_medications(lucie, [
  { name: "Vitamin D", dosage: "400 IU", frequency: "Once a day", reminder_time: "08:15", start_date: Date.current, end_date: Date.current + 90.days },
  { name: "Ibuprofen", dosage: "100mg", frequency: "As needed", reminder_time: "15:00", start_date: Date.current, end_date: Date.current + 5.days },
])

create_medications(marc, [
  { name: "Insulin", dosage: "10 units", frequency: "Twice a day", reminder_time: "07:00", start_date: Date.current, end_date: Date.current + 365.days },
  { name: "Levothyroxine", dosage: "50mcg", frequency: "Once a day", reminder_time: "06:30", start_date: Date.current, end_date: Date.current + 180.days },
])

puts "Done! Created #{User.count} users, #{FamilyMember.count} family members, #{Medication.count} medications."
puts "Demo accounts (password: password123): alice@medilink.dev, bob@medilink.dev, carla@medilink.dev"
