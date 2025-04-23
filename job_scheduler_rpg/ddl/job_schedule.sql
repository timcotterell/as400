-- JOB_SCHEDULE table definition for RPG-based scheduler
CREATE TABLE MYLIB.JOB_SCHEDULE (
    JOB_ID        INTEGER GENERATED ALWAYS AS IDENTITY
                            (START WITH 1 INCREMENT BY 1),
    JOB_NAME      VARCHAR(50) NOT NULL,
    RUN_TIME      TIME NOT NULL,
    FREQUENCY     CHAR(10) NOT NULL DEFAULT 'DAILY',  -- Options: DAILY, ONCE, HOURLY, etc.
    COMMAND       VARCHAR(256) NOT NULL,
    LAST_RUN      TIMESTAMP,  -- Nullable, for tracking
    ACTIVE        CHAR(1) NOT NULL DEFAULT 'Y',       -- Y = Yes, N = No
    PRIMARY KEY (JOB_ID)
);