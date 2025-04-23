**FREE
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt: *nodebugio);

dcl-pr loadScheduledJobs int(10) extproc(*dclcase);
dcl-pr runJobCommand extproc(*dclcase);
  jobId int(10);
  command varchar(256);
end-pr;

// Data structure for jobs (must match what's defined in job_loader.rpgle)
dcl-ds Job extname('JOB_SCHEDULE') end-ds;
dcl-ds JobsList dim(50) likeDS(Job); // Up to 50 jobs

dcl-s i int(10);
dcl-s totalJobs int(10);

dcl-proc main;

  dsply 'Job Scheduler Started...';

  // Load jobs scheduled to run
  totalJobs = loadScheduledJobs();

  if totalJobs <= 0;
     dsply 'No jobs scheduled to run at this time.';
     return;
  endif;

  // Loop through and run jobs
  for i = 1 to totalJobs;
    dsply ('Running job: ' + %trim(JobsList(i).JOB_NAME));
    runJobCommand(JobsList(i).JOB_ID: JobsList(i).COMMAND);
  endfor;

  dsply 'Job Scheduler Completed.';

end-proc;