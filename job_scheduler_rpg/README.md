# ⏱️ RPG Job Scheduler (IBM i)

This project implements a basic job scheduler system for IBM i (AS/400), written entirely in RPG IV Free Format. It reads scheduled jobs from a DB2 table, determines which should run based on the current time, and executes them using QCMDEXC. The system simulates a CRON-like behavior natively on IBM i.

---

## 💡 Features

- 🗂️ Modular RPG design with loader, runner, and controller
- 🕒 Executes commands from a DB2-based job schedule
- 📝 Tracks last run timestamps and logs job execution
- 🔁 Supports future enhancement for job recurrence (daily, hourly, once)

---

## 🗂️ Project Structure

```
job_scheduler_rpg/
├── src/                   # RPG source modules
│   ├── scheduler_main.rpgle
│   ├── job_loader.rpgle
│   ├── job_runner.rpgle
│   └── compile.clle
├── ddl/                   # DB2 table definition
│   └── job_schedule.sql
├── logs/                  # Sample log output
│   └── execution_log_sample.txt
├── docs/                  # Documentation and architecture
│   ├── architecture.png
│   └── compile_instructions.md
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🚀 Getting Started

1. **Create the DB2 Table**
   - Run the SQL in `ddl/job_schedule.sql`

2. **Load RPG Source Files**
   - Copy `.rpgle` files into `QRPGLESRC`
   - Copy `compile.clle` into `QCLSRC`

3. **Compile Using CL**
   ```cl
   CRTBNDCL PGM(MYLIB/COMPILE) SRCFILE(MYLIB/QCLSRC)
   CALL MYLIB/COMPILE
   ```

4. **Run the Scheduler**
   ```cl
   CALL MYLIB/SCHEDULER_MAIN
   ```

---

## 🧰 Future Enhancements

- Frequency types: hourly, weekly, monthly
- Retry logic for failed jobs
- Logging to database or external file
- Web interface or command submission GUI

---

## 👨‍💻 Author

**Timothy Cotterell**  
RPG Developer | IBM i Automation Enthusiast

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
