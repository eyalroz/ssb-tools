START TRANSACTION;
COPY INTO customer  from 'customer.tbl'   USING DELIMITERS '|', '|\n';
COPY INTO date_     from 'date.tbl'       USING DELIMITERS '|', '|\n';
COPY INTO part      from 'part.tbl'       USING DELIMITERS '|', '|\n';
COPY INTO supplier  from 'supplier.tbl'   USING DELIMITERS '|', '|\n';
COPY INTO lineorder from 'lineorder.tbl'  USING DELIMITERS '|', '|\n';
COMMIT;

