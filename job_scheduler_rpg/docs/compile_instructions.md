# 🛠 Compile Instructions for RPG Job Scheduler

## Requirements
- IBM i system with a development library (e.g., MYLIB)
- Source physical files (QRPGLESRC for RPG, QCLSRC for CL)
- DB2 tables created using `/ddl/job_schedule.sql`

## Steps

1. **Create Source Files (if not already present):**
   ```cl
   CRTSRCPF FILE(MYLIB/QRPGLESRC)
   CRTSRCPF FILE(MYLIB/QCLSRC)
   ```

2. **Load all `.rpgle` source members into `QRPGLESRC`.**

3. **Load `compile.clle` into `QCLSRC` as member `COMPILE`.**

4. **Compile the CL program:**
   ```cl
   CRTBNDCL PGM(MYLIB/COMPILE) SRCFILE(MYLIB/QCLSRC)
   ```

5. **Run the compile script to build all RPG modules:**
   ```cl
   CALL MYLIB/COMPILE
   ```

6. **Run the main scheduler:**
   ```cl
   CALL MYLIB/SCHEDULER_MAIN
   ```

## Optional
- Modify the scheduler to support frequencies like HOURLY or WEEKLY.
- Add error logging or email alerts on failure.
