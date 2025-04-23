**FREE
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt: *nodebugio);

dcl-proc generateOrderJson export;
  dcl-pi *n;
    orderId    int(10);
    customerId char(10);
    productId  char(10);
    quantity   int(5);
    orderDate  date;
    status     char(10);
  end-pi;

  dcl-s jsonText varchar(1024);
  dcl-s fileName varchar(256);
  dcl-s fileHandle int(10);

  dcl-s path varchar(256) inz('/home/order_output/');
  dcl-s newline varchar(2) inz(x'0D25'); // CRLF

  // Build JSON string
  jsonText = '{' + newline +
             '  "order_id": "' + %char(orderId) + '",' + newline +
             '  "customer_id": "' + %trim(customerId) + '",' + newline +
             '  "product_id": "' + %trim(productId) + '",' + newline +
             '  "quantity": ' + %char(quantity) + ',' + newline +
             '  "order_date": "' + %char(orderDate) + '",' + newline +
             '  "status": "' + %trim(status) + '"' + newline +
             '}';

  // Build file name
  fileName = path + 'order_' + %char(orderId) + '.json';

  // Open the file for writing (create new or overwrite)
  fileHandle = open(%trim(fileName): O_WRONLY + O_CREAT + O_TRUNC: S_IRUSR + S_IWUSR);

  if fileHandle < 0;
     dsply 'Error opening file in IFS.';
     return;
  endif;

  // Write the JSON text
  callp write(fileHandle: %addr(jsonText): %len(%trim(jsonText)));

  // Close the file
  callp close(fileHandle);

end-proc;