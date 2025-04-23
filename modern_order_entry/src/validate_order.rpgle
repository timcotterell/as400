**FREE
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt: *nodebugio);

dcl-proc validateOrder export;
  dcl-pi *n ind;
    productId char(10);
    quantity  int(5);
  end-pi;

  dcl-s isValid ind;

  // Simple hardcoded check – can later be replaced with DB lookup or API call
  if %trim(productId) = *blanks or quantity <= 0;
     isValid = *off;
  else;
     isValid = *on;
  endif;

  return isValid;

end-proc;