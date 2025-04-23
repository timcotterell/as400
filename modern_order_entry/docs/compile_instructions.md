# Compile Instructions for Modern Order Entry System

## Prerequisites

- IBM i system with access to a development library (e.g., MYLIB)
- Source physical files (QRPGLESRC and QCLSRC)
- Tables created using SQL scripts in `/ddl`
- Proper authorities to compile and execute RPGLE programs

## Step-by-Step

1. **Create Source Files** (if not already created)
   ```cl
   CRTSRCPF FILE(MYLIB/QRPGLESRC)
   CRTSRCPF FILE(MYLIB/QCLSRC)