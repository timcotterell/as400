**FREE
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt: *nodebugio);

/copy qsysinc/qrpglesrc,sqlca

dcl-ds Job extname('JOB_SCHEDULE') end-ds;
dcl-ds JobsList dim(50) likeDS(Job); // Up to 50 jobs
dcl-s jobCount int(10);

dcl-proc loadScheduledJobs export;
  dcl-pi *n int(10); // returns the number of jobs found
  end-pi;

  jobCount = 0;

  exec sql
    declare job_cursor cursor for
      select *
      from MYLIB.JOB_SCHEDULE
      where ACTIVE = 'Y'
        and FREQUENCY = 'DAILY'
        and RUN_TIME = CURRENT_TIME
        and (LAST_RUN is null or DATE(LAST_RUN) < CURRENT_DATE);

  exec sql open job_cursor;

  dow sqlcode = 0;
    exec sql fetch next from job_cursor into :JobsList(jobCount + 1);
    if sqlcode = 0;
       jobCount += 1;
    endif;
  enddo;

  exec sql close job_cursor;

  return jobCount;

end-proc;