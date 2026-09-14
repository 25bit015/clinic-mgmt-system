# Modules Documentation - Nyaraka za Miundo

## Reception Module (Modul ya Reception)

### Kazi Kuu (Main Tasks)
1. **Usajili wa Mgonjwa** (Patient Registration)
   - Jina kamili
   - Umri / Tarehe ya kuzaliwa
   - Jinsia
   - Namba ya simu
   - Anwani
   - Namba ya kitambulisho
   - Simba la dharura
   - Historia ya magonjwa

2. **Kuhariri Taarifa** (Edit Patient Info)
   - Update personal details
   - Update contact information
   - Update medical history

3. **Kumtuma Daktar** (Send to Doctor)
   - Kumandisha ID ya mgonjwa
   - Kumandisha sababu ya mjango
   - Kuweka status: "Pending Doctor"

### Database Tables
- `patients` - Taarifa za wagonjwa
- `patient_visits` - Historia ya mjango
- `patient_history` - Historia ya magonjwa

---

## Doctor Module (Modul ya Daktar)

### Kazi Kuu (Main Tasks)
1. **Kupokea Wagonjwa** (Receive Patients)
   - View pending patients from reception
   - See patient history
   - Check previous diagnoses

2. **Kuandika Uchumi wa Kitiba** (Write Prescription)
   - Diagnosis (Uchumi)
   - Symptoms observed (Dalili zilizoonekana)
   - Recommended treatment (Tiba inayopendekezwa)
   - Add notes

3. **Kumtuma Maabara au Famasi** (Send to Lab or Pharmacy)
   - Send to Lab Technician if tests needed
   - Send to Pharmacy with prescription
   - Add required tests/medicines

4. **Kupokea Matokeo** (Receive Results)
   - View lab results from technicians
   - Update patient treatment based on results

### Database Tables
- `consultations` - Uchumi wa kukula (Doctor visits)
- `prescriptions` - Fahamu za tiba
- `diagnoses` - Uchumi
- `doctor_notes` - Viambajengo vya daktar

---

## Lab Technician Module (Modul ya Maabara)

### Kazi Kuu (Main Tasks)
1. **Kupokea Vipimo** (Receive Test Requests)
   - View test requests from doctor
   - See which tests are needed
   - See patient information

2. **Kuandika Matokeo** (Record Test Results)
   - Test type
   - Result values
   - Reference ranges
   - Test date and time
   - Technician notes

3. **Kurejesha Matokeo** (Return Results)
   - Send results back to doctor
   - Mark as "Completed"
   - Add notes if necessary

4. **Kuandika Kumbukumbu** (Maintain Records)
   - Keep history of all tests
   - Track test accuracy
   - Equipment calibration log

### Database Tables
- `test_requests` - Ombi la vipimo
- `test_results` - Matokeo ya vipimo
- `test_types` - Aina za vipimo
- `lab_notes` - Viambajengo vya maabara

---

## Pharmacy Module (Modul ya Famasi)

### Kazi Kuu (Main Tasks)
1. **Uhamiaji wa Dawa** (Pharmacy Stock Management)
   - Kuingiza dawa mpya (Add new medicines)
   - Kuandika sehemu na bei (Record batch and price)
   - Kuandika tarehe ya expiry (Record expiry date)

2. **Hali ya Dawa** (Stock Status)
   - Monitor stock levels
   - Set minimum thresholds
   - Alert when low stock
   - Track expiry dates

3. **Kutoa Dawa** (Dispense Medicines)
   - Receive prescription from doctor
   - Check availability
   - Dispense correct quantity
   - Update stock
   - Record patient details

4. **Kuingiza Dawa Mpya** (Add New Medicines)
   - Medicine name
   - Generic name
   - Dosage form
   - Strength
   - Manufacturer
   - Cost price
   - Selling price

5. **Historia ya Dawa** (Medicine History)
   - Track all dispensing
   - Track stock movements
   - Track expiry management
   - Financial records

### Database Tables
- `medicines` - Dawa zilizopo
- `medicine_batches` - Batch za dawa
- `dispensing` - Kutoa dawa kwa wagonjwa
- `pharmacy_stock` - Hali ya hazina
- `pharmacy_transactions` - Miamala ya famasi
- `pharmacy_notes` - Viambajengo vya famasi