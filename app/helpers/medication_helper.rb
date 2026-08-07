def medication_icon(medication)
  pills = [
    "Aspirin", "Cetirizine",
    "Dafalgan", "Doliprane", "Efferalgan",
    "Ibuprofen", "Imodium",
    "Loratadine", "Melatonin",
    "Naproxen", "Nurofen",
    "Paracetamol",
    "Spasfon"
  ]

  liquid = [
    "Gaviscon"
  ]

  powder = [
    "Smecta"
  ]

  injections = [
    "Insulin",
    "Morphine"
  ]

  vitamins = [
    "Calcium", "Cranberry supplement", "Folic acid", "Iron supplement", "Magnesium",
    "Multivitamin", "Omega-3", "Probiotic", "Vitamin B12", "Vitamin C",
    "Vitamin D", "Zinc"
  ]

  prescription = [
    "Amlodipine", "Amoxicillin", "Atorvastatin", "Clopidogrel", "Diclofenac",
    "Fluoxetine", "Furosemide", "Levothyroxine", "Lexomil", "Lisinopril",
    "Metformin", "Omeprazole", "Prednisone", "Ramipril",
    "Sertraline", "Simvastatin", "Warfarin",
    "Codeine", "Diazepam", "Stilnox", "Tramadol", "Xanax", "Zolpidem",
    "Salbutamol", "Ventolin",
    "Insulin", "Morphine"
  ]
  if pills.include?(medication.name)
    '<i class="fa-solid fa-pills medication-card-icon medication-icon-blue"></i>'.html_safe

  elsif liquid.include?(medication.name)
    '<i class="fa-solid fa-flask medication-card-icon medication-icon-purple"></i>'.html_safe

  elsif vitamins.include?(medication.name)
    '<i class="fa-solid fa-leaf medication-card-icon medication-icon-green"></i>'.html_safe

  elsif injections.include?(medication.name)
    '<i class="fa-solid fa-syringe medication-card-icon medication-icon-orange"></i>'.html_safe

  elsif powder.include?(medication.name)
    '<i class="fa-solid fa-bong medication-card-icon medication-icon-grey"></i>'.html_safe

  elsif prescription.include?(medication.name)
    '<i class="fa-solid fa-capsules medication-card-icon medication-icon-red "></i>'.html_safe
  end
end
