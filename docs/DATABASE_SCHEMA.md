# Database Schema - Muundo wa Database

## Tables Overview

### 1. patients (Wagonjwa)
```sql
CREATE TABLE patients (
  id UUID PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  date_of_birth DATE,
  gender ENUM('M', 'F', 'Other'),
  phone VARCHAR(20),
  email VARCHAR(100),
  address TEXT,
  id_number VARCHAR(50) UNIQUE,
  emergency_contact VARCHAR(100),
  emergency_phone VARCHAR(20),
  medical_history TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('Active', 'Inactive', 'Deleted')
);
```

### 2. patient_visits (Mjango wa Mgonjwa)
```sql
CREATE TABLE patient_visits (
  id UUID PRIMARY KEY,
  patient_id UUID NOT NULL REFERENCES patients(id),
  visit_date TIMESTAMP NOT NULL,
  reason_for_visit VARCHAR(255),
  status ENUM('Pending', 'In Progress', 'Completed', 'Cancelled'),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (patient_id) REFERENCES patients(id)
);
```

### 3. consultations (Uchumi wa Kukula)
```sql
CREATE TABLE consultations (
  id UUID PRIMARY KEY,
  patient_id UUID NOT NULL,
  doctor_id UUID NOT NULL,
  visit_id UUID,
  consultation_date TIMESTAMP NOT NULL,
  symptoms TEXT,
  diagnosis TEXT,
  treatment_plan TEXT,
  notes TEXT,
  status ENUM('Pending', 'In Progress', 'Completed'),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (patient_id) REFERENCES patients(id)
);
```

### 4. prescriptions (Fahamu za Tiba)
```sql
CREATE TABLE prescriptions (
  id UUID PRIMARY KEY,
  consultation_id UUID NOT NULL,
  patient_id UUID NOT NULL,
  doctor_id UUID NOT NULL,
  prescription_date TIMESTAMP NOT NULL,
  status ENUM('Pending', 'Dispensed', 'Completed'),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (consultation_id) REFERENCES consultations(id),
  FOREIGN KEY (patient_id) REFERENCES patients(id)
);
```

### 5. prescription_items (Bidhaa ya Fahamu)
```sql
CREATE TABLE prescription_items (
  id UUID PRIMARY KEY,
  prescription_id UUID NOT NULL,
  medicine_id UUID NOT NULL,
  quantity INT NOT NULL,
  dosage VARCHAR(100),
  frequency VARCHAR(100),
  duration INT,
  instructions TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (prescription_id) REFERENCES prescriptions(id),
  FOREIGN KEY (medicine_id) REFERENCES medicines(id)
);
```

### 6. test_requests (Ombi la Vipimo)
```sql
CREATE TABLE test_requests (
  id UUID PRIMARY KEY,
  consultation_id UUID NOT NULL,
  patient_id UUID NOT NULL,
  doctor_id UUID NOT NULL,
  test_type_id UUID NOT NULL,
  request_date TIMESTAMP NOT NULL,
  status ENUM('Pending', 'In Progress', 'Completed', 'Cancelled'),
  priority ENUM('Low', 'Medium', 'High'),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (consultation_id) REFERENCES consultations(id),
  FOREIGN KEY (patient_id) REFERENCES patients(id),
  FOREIGN KEY (test_type_id) REFERENCES test_types(id)
);
```

### 7. test_results (Matokeo ya Vipimo)
```sql
CREATE TABLE test_results (
  id UUID PRIMARY KEY,
  test_request_id UUID NOT NULL,
  patient_id UUID NOT NULL,
  test_date TIMESTAMP NOT NULL,
  result_value VARCHAR(255),
  result_unit VARCHAR(50),
  reference_range VARCHAR(100),
  status ENUM('Normal', 'Abnormal', 'Critical'),
  technician_id UUID,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (test_request_id) REFERENCES test_requests(id),
  FOREIGN KEY (patient_id) REFERENCES patients(id)
);
```

### 8. test_types (Aina za Vipimo)
```sql
CREATE TABLE test_types (
  id UUID PRIMARY KEY,
  test_name VARCHAR(100) NOT NULL,
  description TEXT,
  reference_range VARCHAR(100),
  unit VARCHAR(50),
  cost DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 9. medicines (Dawa)
```sql
CREATE TABLE medicines (
  id UUID PRIMARY KEY,
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
  status ENUM('Active', 'Discontinued', 'Deleted')
);
```

### 10. medicine_batches (Batch za Dawa)
```sql
CREATE TABLE medicine_batches (
  id UUID PRIMARY KEY,
  medicine_id UUID NOT NULL,
  batch_number VARCHAR(100) UNIQUE,
  quantity_received INT,
  quantity_available INT,
  cost_price DECIMAL(10, 2),
  selling_price DECIMAL(10, 2),
  expiry_date DATE,
  received_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('Available', 'Expired', 'Damaged'),
  FOREIGN KEY (medicine_id) REFERENCES medicines(id)
);
```

### 11. dispensing (Kutoa Dawa)
```sql
CREATE TABLE dispensing (
  id UUID PRIMARY KEY,
  prescription_item_id UUID NOT NULL,
  medicine_batch_id UUID NOT NULL,
  patient_id UUID NOT NULL,
  quantity_dispensed INT NOT NULL,
  dispensing_date TIMESTAMP NOT NULL,
  pharmacist_id UUID,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (prescription_item_id) REFERENCES prescription_items(id),
  FOREIGN KEY (medicine_batch_id) REFERENCES medicine_batches(id),
  FOREIGN KEY (patient_id) REFERENCES patients(id)
);
```

### 12. pharmacy_stock (Hali ya Hazina)
```sql
CREATE TABLE pharmacy_stock (
  id UUID PRIMARY KEY,
  medicine_id UUID NOT NULL,
  total_quantity INT,
  minimum_threshold INT,
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('In Stock', 'Low Stock', 'Out of Stock'),
  FOREIGN KEY (medicine_id) REFERENCES medicines(id)
);
```

### 13. users (Watumiaji)
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  username VARCHAR(100) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  role ENUM('Admin', 'Reception', 'Doctor', 'Technician', 'Pharmacist'),
  phone VARCHAR(20),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```