# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RiskCalculationDetail.find_or_create_by(travel_history: false, contact_with_covid_patient: false, min_symptom_count: 0, max_symptom_count: 0, risk_percent: 5)
RiskCalculationDetail.find_or_create_by(travel_history: true, contact_with_covid_patient: true, min_symptom_count: 1, max_symptom_count: 1, risk_percent: 50)
Zone.find_or_create_by(pincode: '12345', covid_patient_count: 0)