**FREE
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt: *nodebugio);

/copy qsysinc/qrpglesrc,sqlca

// Declare prototype for QCMDEXC
dcl-pr QCMDEXC extpgm('QCMDEXC');
  command char(3000) const;
  length packed(15:5) const;
end-pr;

dcl-proc runJobCommand export;
  dcl-pi *n;
    jobId int(10);
    command varchar(256);
  end-pi;

  dcl-s cmdLen packed(15:5);

  cmdLen = %len(%trim(command));

  // Run the command
  callp QCMDEXC(%trim(command): cmdLen);

  // Log the execution by updating LAST_RUN
  exec sql
    update MYLIB.JOB_SCHEDULE
    set LAST_RUN = CURRENT_TIMESTAMP
    where JOB_ID = :jobId;

end-proc;