# Installation Guide - Mwongozo wa Kusakinisha

## Prerequisites (Mahitaji)
- Node.js 14+ or Python 3.8+
- PostgreSQL 12+
- Git
- npm or pip

## Backend Setup

### Option 1: Node.js Backend

1. Navigate to backend folder
```bash
cd backend
```

2. Install dependencies
```bash
npm install
```

3. Create .env file
```bash
cp .env.example .env
```

4. Configure database in .env
```
DATABASE_URL=postgresql://user:password@localhost:5432/clinic_db
JWT_SECRET=your_secret_key
PORT=5000
```

5. Run migrations
```bash
npm run migrate
```

6. Seed initial data
```bash
npm run seed
```

7. Start server
```bash
npm start
```

### Option 2: Python Flask Backend

1. Navigate to backend folder
```bash
cd backend
```

2. Create virtual environment
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies
```bash
pip install -r requirements.txt
```

4. Create .env file
```bash
cp .env.example .env
```

5. Configure database
```
DATABASE_URL=postgresql://user:password@localhost:5432/clinic_db
SECRET_KEY=your_secret_key
FLASK_PORT=5000
```

6. Run migrations
```bash
flask db upgrade
```

7. Start server
```bash
python app.py
```

## Database Setup

1. Create database
```bash
psql -U postgres
CREATE DATABASE clinic_db;
```

2. Run schema
```bash
psql -U postgres -d clinic_db -f database/schema.sql
```

## Frontend Setup

### React.js Frontend

1. Navigate to frontend folder
```bash
cd frontend
```

2. Install dependencies
```bash
npm install
```

3. Create .env file
```bash
REACT_APP_API_URL=http://localhost:5000/api
```

4. Start development server
```bash
npm start
```

5. Build for production
```bash
npm run build
```

## Running the Application

1. Start PostgreSQL
```bash
# On Linux/Mac
sudo service postgresql start

# On Windows
pg_ctl -D "C:\Program Files\PostgreSQL\data" start
```

2. Start Backend Server
```bash
cd backend
npm start  # or python app.py
```

3. Start Frontend Server
```bash
cd frontend
npm start
```

4. Access application
```
http://localhost:3000
```

## Default Login Credentials

| Role | Username | Password |
|------|----------|----------|
| Admin | admin | admin123 |
| Reception | reception | reception123 |
| Doctor | doctor | doctor123 |
| Technician | technician | tech123 |
| Pharmacist | pharmacist | pharmacy123 |

⚠️ **Change these credentials immediately in production!**