admin_user = User.create!(
  email: "maciek@example.com",
  password: "password",
  password_confirmation: "password",
  role: 1
)

regular_user = User.create!(
  email: "tomek@example.com",
  password: "password",
  password_confirmation: "password",
  role: 0
);

Medication.create!([
  {
    name: "L-Theanine",
    manufacturer: "Aliness",
    form: 1,
    photo: File.open(Rails.root.join('db/seed/attachments/aliness-teanina.jpg')),
    unit: "mg",
    user: regular_user
  },
  {
    name: "L-Taurine",
    manufacturer: "Aliness",
    form: 1,
    photo: File.open(Rails.root.join('db/seed/attachments/aliness-tauryna.jpg')),
    unit: "mg",
    user: regular_user
  },
  {
    name: "B-Complex B-50 Methyl Plus",
    manufacturer: "Aliness",
    form: 1,
    photo: File.open(Rails.root.join('db/seed/attachments/aliness-witamina-b-50.jpg')),
    unit: "mg",
    user: regular_user
  },
  {
    name: "Vitamin Premium Complex",
    manufacturer: "Aliness",
    form: 0,
    description: "Dla mężczyzn",
    photo: File.open(Rails.root.join('db/seed/attachments/aliness-vitamin-complex.jpg')),
    unit: "mg",
    user: admin_user
  },
  {
    name: "Liver Regeneration Complex",
    manufacturer: "Aliness",
    form: 1,
    photo: File.open(Rails.root.join('db/seed/attachments/aliness-liver-regeneration.jpg')),
    unit: "mg",
    user: admin_user
  },
  {
    name: "Fish Omega-3 Forte",
    manufacturer: "Aliness",
    form: 1,
    photo: File.open(Rails.root.join('db/seed/attachments/aliness-fish-omega-3-forte.jpg')),
    unit: "mg",
    user: admin_user
  },
  {
    name: "Cytrynian Magnezu",
    manufacturer: "Aliness",
    form: 1,
    description: "125mg + B6",
    photo: File.open(Rails.root.join('db/seed/attachments/aliness-cytrynian-magnezu.jpg')),
    unit: "mg",
    user: admin_user
  },
  {
    name: "Witamina K2 Mono Forte",
    manufacturer: "Aliness",
    form: 0,
    description: "MK-7 200mg",
    photo: File.open(Rails.root.join('db/seed/attachments/aliness-witamina-k2-mk7.jpg')),
    unit: "mg",
    user: admin_user
  },
  {
    name: "Taurynian Magnezu",
    manufacturer: "Aliness",
    form: 1,
    description: "100mg + B6",
    photo: File.open(Rails.root.join('db/seed/attachments/aliness-taurynian.jpg')),
    unit: "mg",
    user: admin_user
  },
  {
    name: "B-12",
    manufacturer: "Avitale",
    form: 3,
    description: "Metylokobalamina 200mcg",
    photo: File.open(Rails.root.join('db/seed/attachments/avitale-b12.jpg')),
    unit: "mcg",
    user: admin_user
  },
  {
    name: "GABA",
    manufacturer: "Swanson",
    form: 1,
    description: "125mg",
    photo: File.open(Rails.root.join('db/seed/attachments/swanson-gaba.jpg')),
    unit: "mg",
    user: admin_user
  },
  {
    name: "Witamina C",
    manufacturer: "Biomus",
    form: 2,
    photo: File.open(Rails.root.join('db/seed/attachments/biomus-askorbinian-sodu.jpg')),
    unit: "mg",
    user: admin_user
  },
  {
    name: "Super Formuła",
    manufacturer: "Sanprobi",
    form: 1,
    photo: File.open(Rails.root.join('db/seed/attachments/sanprobi-super-formula.jpg')),
    unit: "mg",
    user: admin_user
  },
  {
    name: "Glukonian Potasu",
    manufacturer: "Now Foods",
    form: 2,
    photo: File.open(Rails.root.join('db/seed/attachments/now-glukonian-potasu.jpg')),
    unit: "mg",
    user: admin_user
  }
])
