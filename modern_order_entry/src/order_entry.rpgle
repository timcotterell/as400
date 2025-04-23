**FREE
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt: *nodebugio);

/include 'qrpglesrc,validate_order'
// assuming you’ll modularize this
/include 'qrpglesrc,db_access'
/include 'qrpglesrc,json_output'

dcl-s customerId char(10);
dcl-s productId  char(10);
dcl-s quantity   int(5);
dcl-s status     char(10);
dcl-s isValid    ind;

dcl-s orderId    int(10);
dcl-s orderDate  date;

dcl-proc main;

  // Simulated input (replace with user prompt or API input as needed)
  customerId = 'CUST0001';
  productId  = 'PRD001';
  quantity   = 3;
  orderDate  = %date();
  status     = 'NEW';

  // Step 1: Validate input
  isValid = validateOrder(productId : quantity);
  if not isValid;
     dsply 'Invalid order. Check product ID or quantity.';
     return;
  endif;

  // Step 2: Insert into DB2
  orderId = insertOrder(customerId : productId : quantity : orderDate : status);
  if orderId <= 0;
     dsply 'Order insertion failed.';
     return;
  endif;

  // Step 3: Generate JSON confirmation
  generateOrderJson(orderId : customerId : productId : quantity : orderDate : status);
  dsply 'Order placed successfully. JSON generated.';

end-proc;