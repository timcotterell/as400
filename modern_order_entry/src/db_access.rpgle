**FREE
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt: *nodebugio);

/copy qsysinc/qrpglesrc,sqlca  // Include SQL communications area

dcl-proc insertOrder export;
  dcl-pi *n int(10);
    customerId char(10);
    productId  char(10);
    quantity   int(5);
    orderDate  date;
    status     char(10);
  end-pi;

  dcl-s orderId int(10);

  exec sql
    insert into mylib.orders
      (customer_id, product_id, quantity, order_date, status)
    values
      (:customerId, :productId, :quantity, :orderDate, :status);

  // Get the identity value of the inserted row
  exec sql
    select order_id into :orderId
    from final table (
      insert into mylib.orders
        (customer_id, product_id, quantity, order_date, status)
      values
        (:customerId, :productId, :quantity, :orderDate, :status)
    );

  if sqlcode < 0;
     // log or handle error as needed
     return -1;
  endif;

  return orderId;

end-proc;