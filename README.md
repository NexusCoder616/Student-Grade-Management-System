# 🎓 Student Grade Management System

A comprehensive grade management system implemented in **8086 Assembly Language** for the Computer Organization and Architecture course at SRM University-AP.

![Assembly](https://img.shields.io/badge/Language-Assembly%208086-blue)
![Platform](https://img.shields.io/badge/Platform-EMU8086-green)
![Status](https://img.shields.io/badge/Status-Completed-success)

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technical Details](#technical-details)
- [System Requirements](#system-requirements)
- [Installation & Usage](#installation--usage)
- [Program Structure](#program-structure)
- [Contributors](#contributors)
- [Acknowledgments](#acknowledgments)

## 🔍 Overview

This project demonstrates low-level programming concepts by implementing a fully functional student grade management system using 8086 Assembly Language. The system manages academic records for 25 students, providing sorting, categorization, and retrieval capabilities through a menu-driven interface.

### Project Objectives

- Gain hands-on experience with low-level programming
- Understand data flow and memory management in the 8086 architecture
- Implement sorting algorithms at the assembly level
- Develop proficiency in register manipulation and memory segmentation

## ✨ Features

### 1. **Grade Sorting**
- Implements optimized Bubble Sort algorithm
- Arranges students in descending order by grade
- Maintains data integrity through parallel array synchronization

### 2. **Sorted Table Display**
- Shows ranked list of all students
- Displays student number, grade, and letter category
- Clean, formatted table output

### 3. **Student Search**
- Linear search implementation
- Quick lookup by roll number
- Displays individual student grade and category

### 4. **Grade Categorization**
- **A Grade:** ≥ 90
- **B Grade:** 80 - 89
- **C Grade:** 70 - 79
- **D Grade:** 60 - 69
- **F Grade:** < 60

## 🔧 Technical Details

### Architecture Components

**Data Structures:**
- **Parallel Arrays:** Synchronized arrays for roll numbers and grades
- **Memory Segments:** Efficient use of Data Segment (DS) for storage

**Algorithms:**
- **Bubble Sort:** O(n²) complexity, suitable for dataset of 25 students
- **Linear Search:** O(n) lookup time for student records

**Key Implementation Features:**
- Register-level data processing
- Memory segmentation and addressing
- Software interrupt handling (INT 21h)
- Conditional branching and flag management
- Menu-driven user interface

### Sample Data

The system comes preloaded with:
- 25 student roll numbers (1-25)
- 25 corresponding grades (0-100 scale)
- Randomized grade distribution for testing

## 💻 System Requirements

- **Emulator:** EMU8086 (or compatible 8086 emulator)
- **Architecture:** Intel 8086 processor (emulated)
- **Operating System:** DOS environment (emulated)
- **Memory:** Minimal RAM requirements (< 1 MB)

## 🚀 Installation & Usage

### Step 1: Setup

1. Download and install [EMU8086](https://emu8086-microprocessor-emulator.en.softonic.com/)
2. Clone this repository or download the source code:
   ```bash
   git clone https://github.com/yourusername/student-grade-management-8086.git
   ```

### Step 2: Running the Program

1. Open EMU8086
2. Load the `.asm` file into the emulator
3. Click **Emulate** or press **F5** to compile
4. Click **Run** or press **F9** to execute

### Step 3: Using the System

**Main Menu Options:**

```
1. Sort Students by Grade    → Sorts all records in descending order
2. Display Sorted Table       → Shows complete ranked student list
3. Search by Roll Number      → Find specific student record
4. Exit                       → Terminate program
```

**Important:** Always select Option 1 (Sort) before using Options 2 or 3!

## 📁 Program Structure

```
student-grade-management-8086/
│
├── src/
│   └── main.asm              # Complete source code
│
├── docs/
│   └── project-report.pdf    # Detailed documentation
│
├── screenshots/
│   ├── menu.png              # Main menu interface
│   ├── sorted-table.png      # Sorted results display
│   └── search-result.png     # Search functionality
│
└── README.md                 # This file
```

### Code Segments

| Segment | Purpose |
|---------|---------|
| **Data Segment** | Stores student arrays, menu strings, and messages |
| **Stack Segment** | Manages function calls and temporary data |
| **Code Segment** | Contains all program logic and procedures |

## 👥 Contributors

This project was developed by students from the **Department of Computer Science and Engineering**, SRM University-AP:

- **Bandi Srinivasa Karthikeya** - AP23110010124
- **Kothuri Siva Jathin Chakravarthy** - AP23110010007
- **Maydiga Surya Sri** - AP23110010302
- **Fizan Baig Mohammed** - AP23110010065
- **L. Charme Srija** - AP23110010099

### Guidance

**Dr. Deepthi K C Kakumani**  
Assistant Professor  
Department of Literature and Languages  
SRM University-AP

## 🎯 Learning Outcomes

Through this project, we gained:

- Deep understanding of 8086 instruction set architecture
- Practical experience with memory addressing modes
- Proficiency in register manipulation and data movement
- Knowledge of low-level control flow and branching
- Skills in implementing algorithms without high-level abstractions
- Appreciation for the complexity underlying modern programming languages

## 📝 License

This project is submitted as part of academic coursework at SRM University-AP. All rights reserved by the contributors.

## 🙏 Acknowledgments

We would like to thank:

- **Dr. Deepthi K C Kakumani** for her guidance and support
- **SRM University-AP** for providing the resources and learning environment
- The **Computer Organization and Architecture** course for the foundational knowledge

---

**Course:** Computer Organization and Architecture  
**Institution:** SRM University-AP, Andhra Pradesh  
**Academic Year:** 2024-2025  
**Submission Date:** April 2025

---

*For questions or feedback, please open an issue in this repository.*
