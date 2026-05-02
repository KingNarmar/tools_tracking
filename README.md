# Tools Tracking System

**Tools Tracking System** is a Flutter-based local warehouse custody tracking application designed to manage workers, tools, issue/return transactions, and worker custody reports.

This project was built as the first version of the M.I.N.A system idea.

It focuses on solving a real warehouse problem: tracking tools issued to workers, returned quantities, open custody balances, and generating basic reports using a local offline database.

> **Project Status:** Completed / First Version  
> **System Type:** Offline / Local Application  
> **Main Purpose:** Tool custody tracking and worker accountability  
> **Next Evolution:** Rebuilt later as M.I.N.A System with online, multi-company, and multi-user support

---

## Project Overview

The Tools Tracking System was created to help warehouse teams manage tool custody in a more organized way.

Instead of relying only on manual records, spreadsheets, or paper-based tracking, this application provides a simple local system for:

- Managing workers
- Managing tools
- Recording tool issue transactions
- Recording tool return transactions
- Tracking custody balances
- Saving issue/return image references
- Searching transactions
- Generating worker reports as PDF files

This version is designed mainly for internal/local use and stores data on the device using a local database.

---

## Why This Project Was Built

In warehouse operations, tool custody can easily become difficult to control when workers receive and return tools daily.

Common problems include:

- Missing tools
- Unclear responsibility
- Manual tracking mistakes
- No quick way to know what is still with each worker
- Difficulty preparing custody reports
- Lack of visual proof during issue/return transactions

This project was built to reduce these problems by creating a digital workflow for tool custody tracking.

---

## Main Features

### 1. Login System

The application includes a basic login screen.

A default admin user is created automatically when the database is empty.

Default demo credentials:

| Field | Value |
|---|---|
| Username | `admin` |
| Password | `admin123` |
| Role | `admin` |

> Note: This login system is for local/internal testing and is not intended as a production-level authentication system.

---

### 2. Main Menu

The application contains a simple main menu that gives access to the main modules:

- Manage Workers
- Manage Tools
- Transactions
- Reports

---

### 3. Workers Management

The Workers module allows the user to manage worker information.

Worker records include:

- Worker name
- Job title
- Department
- HR code

The system also includes validation to help prevent duplicate HR codes.

---

### 4. Tools Management

The Tools module allows the user to manage tools and inventory-related items.

Tool records include:

- Tool ID
- Tool name
- Unit of measure

The system can generate the next tool ID automatically using a format like:

```text
TOOL-001
TOOL-002
TOOL-003
```

---

### 5. Transactions

The Transactions module is used to record tool custody movements.

Each transaction can record:

- Transaction ID
- Date and time
- Worker
- Tool
- Issue quantity
- Return quantity
- Issue image path
- Return image path

Transaction IDs are generated automatically using a format like:

```text
TRX-001
TRX-002
TRX-003
```

---

### 6. Custody Balance Calculation

The system calculates worker/tool balance based on issue and return quantities.

The basic logic is:

```text
Custody Balance = Total Issued Quantity - Total Returned Quantity
```

This helps identify what tools are still in a worker's custody.

---

### 7. Reports

The Reports module allows the user to:

- View transaction records
- Search by worker or tool
- Select a worker
- Generate a PDF report for that worker

The report is designed to support custody tracking and worker accountability.

---

### 8. Image Support

The system includes support for saving image paths related to transactions.

This can be used to attach proof of tool condition during:

- Tool issue
- Tool return

This feature helps improve accountability and reduce disputes about tool condition.

---

## Database

This project uses a local database built with Drift.

The main database tables are:

- Workers
- Tools
- Transactions
- Users

### Workers Table

Stores worker information:

- ID
- Name
- Job title
- Department
- HR code

### Tools Table

Stores tool information:

- ID
- Tool ID
- Tool name
- Unit

### Transactions Table

Stores issue and return records:

- ID
- Transaction ID
- Date
- Worker ID
- Tool ID
- Issue quantity
- Return quantity
- Issue image path
- Return image path

### Users Table

Stores local login users:

- ID
- Username
- Password
- Role

---

## Technology Stack

The project is built using:

- Flutter
- Dart
- Drift
- SQLite
- Provider
- Image Picker
- PDF package
- Printing package
- Open File package
- Intl package
- Path Provider

---

## Packages Used

Main packages used in this project:

```yaml
drift
sqlite3_flutter_libs
path_provider
path
provider
image_picker
pdf
printing
open_file
intl
```

Development packages:

```yaml
drift_dev
build_runner
flutter_launcher_icons
flutter_lints
```

---

## Project Structure

The project follows a simple structure suitable for the first version of the application.

```text
lib
├── data
│   ├── app_database.dart
│   ├── app_database.g.dart
│   └── database_provider.dart
│
├── pages
│   ├── login_page.dart
│   ├── main_menu_page.dart
│   ├── workers_page.dart
│   ├── tools_page.dart
│   ├── transactions_page.dart
│   └── reports_page.dart
│
├── utils
│   └── pdf_generator.dart
│
└── main.dart
```

---

## Application Flow

```text
main.dart
   ↓
Initialize local database
   ↓
Create default admin user if users table is empty
   ↓
Login Page
   ↓
Main Menu
   ↓
Workers / Tools / Transactions / Reports
```

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/KingNarmar/tools_tracking.git
```

### 2. Navigate to the project folder

```bash
cd tools_tracking
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Generate Drift files

If generated files are missing or need to be rebuilt, run:

```bash
dart run build_runner build
```

If there are conflicting generated files, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Run the application

```bash
flutter run
```

---

## Run on Windows

```bash
flutter run -d windows
```

---

## Run on Android Emulator

```bash
flutter run
```

---

## Important Notes

- This version is designed as an offline/local application.
- Data is stored locally on the device.
- The login system is basic and intended for internal/demo usage.
- The database is stored using Drift and SQLite.
- The project was built as the first practical version of the tool custody tracking idea.
- The UI is simple and functional, focused mainly on solving the operational problem.
- This project later inspired the development of the new M.I.N.A System.

---

## Limitations of This Version

This first version does not include:

- Online database
- Multi-company support
- Multi-user cloud access
- Advanced role-based permissions
- Cloud authentication
- Web dashboard
- Real-time synchronization
- Advanced reporting dashboard
- Responsive UI for all device sizes

These limitations are the reason behind rebuilding the system later into a more scalable version.

---

## Future Evolution

This project became the foundation for a newer and more advanced system:

**M.I.N.A System**  
**Materials Inventory Navigation Assistant**

The new version is being designed to support:

- Online access
- Multi-company structure
- Multiple users
- Different roles and permissions
- Responsive layouts for desktop, tablet, and mobile
- Better UI/UX
- More scalable architecture
- Future SaaS-like structure

---

## Project Value

This project is valuable because it was built from a real warehouse need.

It shows how software can be used to solve daily operational problems such as:

- Tool custody tracking
- Worker accountability
- Return monitoring
- Report generation
- Reducing manual tracking errors
- Improving warehouse control

---

## About the Project

Tools Tracking System is the first practical version of a warehouse custody tracking solution.

It represents the starting point of turning real warehouse experience into software.

The project was later upgraded conceptually into M.I.N.A System, which aims to become a larger online inventory and custody management platform.

---

## Author

Developed by **Mina Adly**

Warehouse Manager and Flutter developer building practical software solutions based on real warehouse and inventory management experience.