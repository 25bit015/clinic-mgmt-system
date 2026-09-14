-- Clinic Management System Database Schema
-- V1: Initial Schema Creation

-- Create enum types
CREATE TYPE gender_enum AS ENUM ('M', 'F', 'Other');
CREATE TYPE status_enum AS ENUM ('Active', 'Inactive', 'Deleted');
CREATE TYPE visit_status AS ENUM ('Pending', 'In Progress', 'Completed', 'Cancelled');
CREATE TYPE consultation_status AS ENUM ('Pending', 'In Progress', 'Completed');
CREATE TYPE prescription_status AS ENUM ('Pending', 'Dispensed', 'Completed');
CREATE TYPE test_request_status AS ENUM ('Pending', 'In Progress', 'Completed', 'Cancelled');
CREATE TYPE priority_enum AS ENUM ('Low', 'Medium', 'High');
CREATE TYPE result_status AS ENUM ('Normal', 'Abnormal', 'Critical');
CREATE TYPE user_role AS ENUM ('Admin', 'Reception', 'Doctor', 'Technician', 'Pharmacist');
CREATE TYPE medicine_status AS ENUM ('Active', 'Discontinued', 'Deleted');
CREATE TYPE batch_status AS ENUM ('Available', 'Expired', 'Damaged');
CREATE TYPE stock_status AS ENUM ('In Stock', 'Low Stock', 'Out of Stock');

-- Users Table
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  username VARCHAR(100) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  role user_role NOT NULL,
  phone VARCHAR(20),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Patients Table
CREATE TABLE patients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  date_of_birth DATE,
  gender gender_enum,
  phone VARCHAR(20),
  email VARCHAR(100),
  address TEXT,
  id_number VARCHAR(50) UNIQUE,
  emergency_contact VARCHAR(100),
  emergency_phone VARCHAR(20),
  medical_history TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status status_enum DEFAULT 'Active'
);

-- Patient Visits Table
CREATE TABLE patient_visits (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  visit_date TIMESTAMP NOT NULL,
  reason_for_visit VARCHAR(255),
  status visit_status DEFAULT 'Pending',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Consultations Table
CREATE TABLE consultations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  doctor_id UUID NOT NULL REFERENCES users(id) ON DELETE SET NULL,
  visit_id UUID REFERENCES patient_visits(id) ON DELETE SET NULL,
  consultation_date TIMESTAMP NOT NULL,
  symptoms TEXT,
  diagnosis TEXT,
  treatment_plan TEXT,
  notes TEXT,
  status consultation_status DEFAULT 'Pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Medicines Table
CREATE TABLE medicines (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  generic_name VARCHAR(100),
  description TEXT,
  dosage_form VARCHAR(50),
  strength VARCHAR(50),
  manufacturer VARCHAR(100),
  cost_price DECIMAL(10, 2),
  selling_price DECIMAL(10, 2),
  unit_of_measure VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status medicine_status DEFAULT 'Active'
);

-- Medicine Batches Table
CREATE TABLE medicine_batches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  medicine_id UUID NOT NULL REFERENCES medicines(id) ON DELETE CASCADE,
  batch_number VARCHAR(100) UNIQUE NOT NULL,
  quantity_received INT NOT NULL,
  quantity_available INT NOT NULL,
  cost_price DECIMAL(10, 2),
  selling_price DECIMAL(10, 2),
  expiry_date DATE NOT NULL,
  received_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status batch_status DEFAULT 'Available'
);

-- Prescriptions Table
CREATE TABLE prescriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consultation_id UUID NOT NULL REFERENCES consultations(id) ON DELETE CASCADE,
  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  doctor_id UUID NOT NULL REFERENCES users(id) ON DELETE SET NULL,
  prescription_date TIMESTAMP NOT NULL,
  status prescription_status DEFAULT 'Pending',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Prescription Items Table
CREATE TABLE prescription_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  prescription_id UUID NOT NULL REFERENCES prescriptions(id) ON DELETE CASCADE,
  medicine_id UUID NOT NULL REFERENCES medicines(id) ON DELETE SET NULL,
  quantity INT NOT NULL,
  dosage VARCHAR(100),
  frequency VARCHAR(100),
  duration INT,
  instructions TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Test Types Table
CREATE TABLE test_types (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  test_name VARCHAR(100) NOT NULL,
  description TEXT,
  reference_range VARCHAR(100),
  unit VARCHAR(50),
  cost DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Test Requests Table
CREATE TABLE test_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consultation_id UUID NOT NULL REFERENCES consultations(id) ON DELETE CASCADE,
  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  doctor_id UUID NOT NULL REFERENCES users(id) ON DELETE SET NULL,
  test_type_id UUID NOT NULL REFERENCES test_types(id) ON DELETE SET NULL,
  request_date TIMESTAMP NOT NULL,
  status test_request_status DEFAULT 'Pending',
  priority priority_enum DEFAULT 'Medium',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Test Results Table
CREATE TABLE test_results (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  test_request_id UUID NOT NULL REFERENCES test_requests(id) ON DELETE CASCADE,
  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  test_date TIMESTAMP NOT NULL,
  result_value VARCHAR(255),
  result_unit VARCHAR(50),
  reference_range VARCHAR(100),
  status result_status,
  technician_id UUID REFERENCES users(id) ON DELETE SET NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dispensing Table
CREATE TABLE dispensing (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  prescription_item_id UUID NOT NULL REFERENCES prescription_items(id) ON DELETE CASCADE,
  medicine_batch_id UUID NOT NULL REFERENCES medicine_batches(id) ON DELETE SET NULL,
  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  quantity_dispensed INT NOT NULL,
  dispensing_date TIMESTAMP NOT NULL,
  pharmacist_id UUID REFERENCES users(id) ON DELETE SET NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Pharmacy Stock Table
CREATE TABLE pharmacy_stock (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  medicine_id UUID NOT NULL UNIQUE REFERENCES medicines(id) ON DELETE CASCADE,
  total_quantity INT DEFAULT 0,
  minimum_threshold INT DEFAULT 10,
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status stock_status DEFAULT 'In Stock'
);

-- Create indexes for better performance
CREATE INDEX idx_patient_visits_patient_id ON patient_visits(patient_id);
CREATE INDEX idx_patient_visits_status ON patient_visits(status);
CREATE INDEX idx_consultations_patient_id ON consultations(patient_id);
CREATE INDEX idx_consultations_doctor_id ON consultations(doctor_id);
CREATE INDEX idx_consultations_status ON consultations(status);
CREATE INDEX idx_prescriptions_patient_id ON prescriptions(patient_id);
CREATE INDEX idx_prescriptions_status ON prescriptions(status);
CREATE INDEX idx_test_requests_patient_id ON test_requests(patient_id);
CREATE INDEX idx_test_requests_status ON test_requests(status);
CREATE INDEX idx_test_results_test_request_id ON test_results(test_request_id);
CREATE INDEX idx_dispensing_patient_id ON dispensing(patient_id);
CREATE INDEX idx_dispensing_dispensing_date ON dispensing(dispensing_date);
CREATE INDEX idx_medicine_batches_expiry_date ON medicine_batches(expiry_date);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_medicines_status ON medicines(status);
