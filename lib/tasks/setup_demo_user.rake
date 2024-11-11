# Usage: rake db:create_demo_user

namespace :db do
  desc "Creates a demo user with predefined data"
  task create_demo_user: :environment do
    demo_user = User.find_by(email: "demo@silentdose.com")

    if demo_user
      puts "Deleting existing demo user and related records..."
      demo_user.destroy
    end

    demo_user = User.create!(
      email: "demo@silentdose.com",
      password: "password",
      password_confirmation: "password",
      role: 0
    )
    puts "Created demo user with email: #{demo_user.email}"

    medications = [
      {
        name: "L-Theanine",
        manufacturer: "Aliness",
        form: 1,
        photo: File.open(Rails.root.join("db/seed/attachments/aliness-teanina.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "L-Taurine",
        manufacturer: "Aliness",
        form: 1,
        photo: File.open(Rails.root.join("db/seed/attachments/aliness-tauryna.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "B-Complex B-50 Methyl Plus",
        manufacturer: "Aliness",
        form: 1,
        photo: File.open(Rails.root.join("db/seed/attachments/aliness-witamina-b-50.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "Vitamin Premium Complex",
        manufacturer: "Aliness",
        form: 0,
        description: "Dla mężczyzn",
        photo: File.open(Rails.root.join("db/seed/attachments/aliness-vitamin-complex.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "Liver Regeneration Complex",
        manufacturer: "Aliness",
        form: 1,
        photo: File.open(Rails.root.join("db/seed/attachments/aliness-liver-regeneration.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "Fish Omega-3 Forte",
        manufacturer: "Aliness",
        form: 1,
        photo: File.open(Rails.root.join("db/seed/attachments/aliness-fish-omega-3-forte.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "Cytrynian Magnezu",
        manufacturer: "Aliness",
        form: 1,
        description: "125mg + B6",
        photo: File.open(Rails.root.join("db/seed/attachments/aliness-cytrynian-magnezu.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "Witamina K2 Mono Forte",
        manufacturer: "Aliness",
        form: 0,
        description: "MK-7 200mg",
        photo: File.open(Rails.root.join("db/seed/attachments/aliness-witamina-k2-mk7.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "Taurynian Magnezu",
        manufacturer: "Aliness",
        form: 1,
        description: "100mg + B6",
        photo: File.open(Rails.root.join("db/seed/attachments/aliness-taurynian.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "B-12",
        manufacturer: "Avitale",
        form: 3,
        description: "Metylokobalamina 200mcg",
        photo: File.open(Rails.root.join("db/seed/attachments/avitale-b12.jpg")),
        unit: "mcg",
        user: demo_user
      },
      {
        name: "GABA",
        manufacturer: "Swanson",
        form: 1,
        description: "125mg",
        photo: File.open(Rails.root.join("db/seed/attachments/swanson-gaba.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "Witamina C",
        manufacturer: "Biomus",
        form: 2,
        photo: File.open(Rails.root.join("db/seed/attachments/biomus-askorbinian-sodu.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "Super Formuła",
        manufacturer: "Sanprobi",
        form: 1,
        photo: File.open(Rails.root.join("db/seed/attachments/sanprobi-super-formula.jpg")),
        unit: "mg",
        user: demo_user
      },
      {
        name: "Glukonian Potasu",
        manufacturer: "Now Foods",
        form: 2,
        photo: File.open(Rails.root.join("db/seed/attachments/now-glukonian-potasu.jpg")),
        unit: "mg",
        user: demo_user
      }
    ]

    Medication.create!(medications)
    puts "Created #{medications.size} medications for demo user."

    reminder_times = [
      { time: "08:00", user: demo_user },
      { time: "12:00", user: demo_user },
      { time: "16:00", user: demo_user },
      { time: "20:00", user: demo_user }
    ]

    ReminderTime.create!(reminder_times)
    puts "Created #{reminder_times.size} reminder times for demo user."

    report = DailyReport.create!(
      user: demo_user,
      report_date: Date.today,
      title: "Daily Report for #{Date.today}",
      daily_reports_medications_attributes: demo_user.medications.sample(5).map do |medication|
        { medication_id: medication.id, dosage: "1", user: demo_user }
      end
    )

    puts "Created DailyReport for #{report.report_date} with #{report.medications.count} medications."
  end
end
