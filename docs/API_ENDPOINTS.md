# API Endpoints Documentation - Nyaraka za API

## Reception Module Endpoints

### Patient Management
```
POST   /api/reception/patients              - Register new patient
GET    /api/reception/patients              - List all patients
GET    /api/reception/patients/:id          - Get patient details
PUT    /api/reception/patients/:id          - Update patient info
DELETE /api/reception/patients/:id          - Delete patient
```

### Patient Visits
```
POST   /api/reception/visits                - Create new visit
GET    /api/reception/visits/:id            - Get visit details
PUT    /api/reception/visits/:id            - Update visit
GET    /api/reception/visits/patient/:id    - Get patient's visit history
```

---

## Doctor Module Endpoints

### Patient Queue
```
GET    /api/doctor/patients/pending         - Get pending patients
GET    /api/doctor/patients/:id             - Get patient details & history
GET    /api/doctor/patients/:id/history     - Get complete patient history
```

### Consultations
```
POST   /api/doctor/consultations            - Start consultation
PUT    /api/doctor/consultations/:id        - Update consultation
GET    /api/doctor/consultations/:id        - Get consultation details
```

### Prescriptions
```
POST   /api/doctor/prescriptions            - Create prescription
GET    /api/doctor/prescriptions/:id        - Get prescription details
PUT    /api/doctor/prescriptions/:id        - Update prescription
```

### Test Requests
```
POST   /api/doctor/test-requests            - Request lab tests
GET    /api/doctor/test-requests/:id        - Get test request
GET    /api/doctor/test-results/:id         - Get test results
```

---

## Lab Technician Module Endpoints

### Test Management
```
GET    /api/lab/test-requests/pending       - Get pending test requests
GET    /api/lab/test-requests/:id           - Get test request details
GET    /api/lab/test-types                  - Get available test types
```

### Test Results
```
POST   /api/lab/test-results                - Record test result
PUT    /api/lab/test-results/:id            - Update test result
GET    /api/lab/test-results/:id            - Get test result
GET    /api/lab/test-results/patient/:id    - Get patient's test history
```

### Result Return
```
PUT    /api/lab/test-requests/:id/complete  - Mark test as completed
```

---

## Pharmacy Module Endpoints

### Medicines
```
GET    /api/pharmacy/medicines               - List all medicines
POST   /api/pharmacy/medicines               - Add new medicine
PUT    /api/pharmacy/medicines/:id           - Update medicine
GET    /api/pharmacy/medicines/:id           - Get medicine details
```

### Medicine Batches
```
POST   /api/pharmacy/batches                 - Add new batch
GET    /api/pharmacy/batches                 - List all batches
PUT    /api/pharmacy/batches/:id             - Update batch
GET    /api/pharmacy/batches/:id             - Get batch details
```

### Dispensing
```
GET    /api/pharmacy/prescriptions/pending   - Get pending prescriptions
POST   /api/pharmacy/dispensing              - Dispense medicine
GET    /api/pharmacy/dispensing/:id          - Get dispensing details
GET    /api/pharmacy/dispensing/patient/:id  - Get patient's dispensing history
```

### Stock Management
```
GET    /api/pharmacy/stock                   - Get stock status
GET    /api/pharmacy/stock/:id               - Get medicine stock details
PUT    /api/pharmacy/stock/:id               - Update stock levels
GET    /api/pharmacy/stock/low-stock         - Get low stock items
GET    /api/pharmacy/stock/expiring          - Get expiring medicines
```

---

## Admin/Common Endpoints

### Users
```
POST   /api/admin/users                     - Create user
GET    /api/admin/users                     - List users
PUT    /api/admin/users/:id                 - Update user
DELETE /api/admin/users/:id                 - Delete user
```

### Authentication
```
POST   /api/auth/login                      - Login
POST   /api/auth/logout                     - Logout
POST   /api/auth/refresh                    - Refresh token
```

### Reports
```
GET    /api/reports/patients                - Patient statistics
GET    /api/reports/doctor                  - Doctor statistics
GET    /api/reports/pharmacy                - Pharmacy statistics
GET    /api/reports/lab                     - Lab statistics
```