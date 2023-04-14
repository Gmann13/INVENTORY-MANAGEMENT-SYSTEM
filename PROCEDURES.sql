---------------------------------------------------------------
-------------------SEQUENCE FOR CUSTOMER ID--------------------
---------------------------------------------------------------
drop sequence customer_id_seq;
create sequence customer_id_seq
  START WITH 107
  INCREMENT BY 1
  MAXVALUE 999
  NOCYCLE
  CACHE 20;
  
---------------------------------------------------------------
-------------------SEQUENCE FOR ADMIN ID--------------------
---------------------------------------------------------------
create sequence admin_id_seq
START WITH 11
INCREMENT BY 1
MAXVALUE 99
NOCYCLE
CACHE 20;

---------------------------------------------------------------
----------------------SEQUENCE FOR SUPPLIER ID-----------------
---------------------------------------------------------------
drop sequence supplier_id_seq;
create sequence supplier_id_seq
  START WITH 16
  INCREMENT BY 1
  MAXVALUE 999
  NOCYCLE
  CACHE 20;
  
  ---------------------------------------------------------------
----------------SEQUENCE FOR PRODUCT RETURN ID-----------------
---------------------------------------------------------------
drop sequence PRODUCT_RETURN_ID_SEQ;
create sequence PRODUCT_RETURN_ID_SEQ
  START WITH 11
  INCREMENT BY 1
  MAXVALUE 999
  NOCYCLE
  CACHE 20;
  
---------------------------------------------------------------
------------------SEQUENCE FOR RETURN TRANSACTION--------------
---------------------------------------------------------------
drop sequence RETURN_NUMBER_SEQ;
create sequence RETURN_NUMBER_SEQ
  START WITH 7
  INCREMENT BY 1
  MAXVALUE 999
  NOCYCLE
  CACHE 20;  
 ---------------------------------------------------------------
-------------------SEQUENCE FOR ORDER NUMBER--------------------
---------------------------------------------------------------
drop sequence order_number_seq;
create sequence order_number_seq
  START WITH 110
  INCREMENT BY 1
  MAXVALUE 999
  NOCYCLE
  CACHE 20;
  
-------------------------------------------------------------------
-------------------SEQUENCE FOR PRODUCT SALE ID--------------------
-------------------------------------------------------------------
drop sequence sale_id_seq;
create sequence sale_id_seq
  START WITH 110
  INCREMENT BY 1
  MAXVALUE 999
  NOCYCLE
  CACHE 20;
 
 ------------------------------------------------------------------------------
-------------------SEQUENCE FOR SUPPLIER TRANSACTION NUMBER--------------------
-------------------------------------------------------------------------------
drop sequence supplier_transaction_id_seq;
create sequence supplier_transaction_id_seq
  START WITH 110
  INCREMENT BY 1
  MAXVALUE 999
  NOCYCLE
  CACHE 20;
---------------------------------------------------------------
-----------------SEQUENCE FOR STOCK ID-------------------------
---------------------------------------------------------------
SELECT * FROM STOCK;
drop sequence stock_id_seq;
create sequence stock_id_seq
  START WITH 16
  INCREMENT BY 1
  MAXVALUE 999
  NOCYCLE
  CACHE 20;
  
--------------------------------------------------------------------------------
----------------------------PROCEDURE CUSTOMER ONBOARDING-----------------------
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE customer_onboarding (
    p_customer_id number,
    p_cus_f_name  VARCHAR2,
    p_cus_l_name  VARCHAR2,
    p_cus_dob DATE,
    p_cus_since date,
    p_cus_gender  VARCHAR2,
    p_cus_contact_no NUMBER,
    p_cus_alternate_no NUMBER,
    p_cus_email_id VARCHAR2,
    p_cus_address_1 VARCHAR2,
    p_cus_address_2 VARCHAR2,
    p_cus_city VARCHAR2,
    p_cus_state VARCHAR2,
    p_cus_country VARCHAR2,
    p_cus_zip NUMBER
)
IS
    v_customer_id NUMBER;
    v_email_exists NUMBER;
    v_contact_exists number;
    EX_RAISE_EMAIL_ERROR EXCEPTION;
    EX_RAISE_CONTACT_ERROR EXCEPTION;
    INVALID_DATE_OF_BIRTH EXCEPTION;
    INVALID_CONTACT_NO EXCEPTION;
    INVALID_FIRST_NAME EXCEPTION;

BEGIN
----------------EXCEPTION QUERY--------------
    SELECT COUNT(*) INTO v_email_exists FROM customer WHERE cus_email_id = p_cus_email_id;
    SELECT COUNT(*) INTO v_contact_exists FROM customer WHERE cus_contact_no = p_cus_contact_no;
        
    IF v_email_exists > 0 THEN
      RAISE  EX_RAISE_EMAIL_ERROR;
    END IF;
    IF v_contact_exists > 0 THEN
      RAISE  EX_RAISE_CONTACT_ERROR;
    END IF;
    IF p_cus_f_name is NULL   then
      RAISE INVALID_FIRST_NAME;
    END IF;
    IF p_cus_contact_no is NULL or  LENGTH(p_cus_contact_no) != 10  then
       RAISE INVALID_CONTACT_NO;
    END IF;        
    IF p_cus_dob is NULL or ((sysdate - p_cus_dob)/365) < 13 then
       RAISE INVALID_DATE_OF_BIRTH;
    END IF;
   
--------INSERTING PRIMARY KEY---------
       SELECT customer_id_seq.currVAL INTO v_customer_id FROM DUAL;

----------Insert new customer record into the database----------
    INSERT INTO customer (
                  customer_id,
                  cus_f_name,
                  cus_l_name,
                  cus_dob,
                  cus_since,
                  cus_gender,
                  cus_contact_no,
                  cus_alternate_no,
                  cus_email_id,
                  cus_address_1,
                  cus_address_2,
                  cus_city,
                  cus_state,
                  cus_country,
                  cus_zip
    ) VALUES (
                  v_customer_id,
                  p_cus_f_name,
                  p_cus_l_name,
                  p_cus_dob,
                  SYSDATE,
                  p_cus_gender,
                  p_cus_contact_no,
                  p_cus_alternate_no,
                  p_cus_email_id,
                  p_cus_address_1,
                  p_cus_address_2,
                  p_cus_city,
                  p_cus_state,
                  p_cus_country,
                  p_cus_zip  
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Customer ' || v_customer_id || ' onboarded successfully!');
    
    EXCEPTION
    WHEN EX_RAISE_EMAIL_ERROR THEN
      dbms_output.put_line('Customer email id already exists. Please use another email id.');
    RETURN;
    WHEN EX_RAISE_CONTACT_ERROR THEN
      dbms_output.put_line('Customer CONTACT NO already exists. Please use another email id.');
    RETURN;
    WHEN INVALID_FIRST_NAME THEN
      dbms_output.put_line('YOU DID NOT ADD A FIRST NAME. PLEASE ADD A FIRST NAME');
    RETURN;
    WHEN INVALID_CONTACT_NO THEN
      dbms_output.put_line('INVALID CONTACT NUMBER. ADD A 10 DIGIT CONTACT NUMBER');
    RETURN;
    WHEN INVALID_DATE_OF_BIRTH THEN
      dbms_output.put_line('AGE RESTRICTION!!');
    RETURN;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
  
--------------------------------------------------------------------------------
------------------------PROCEDURE ADMIN ONBOARDING------------------------------
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE admin_onboarding (
                    p_ADMIN_ID NUMBER,
                    p_ADMIN_F_NAME VARCHAR2,
                    p_ADMIN_L_NAME VARCHAR2,
                    p_ADMIN_DOB DATE,
                    p_ADMIN_SINCE	DATE,
                    p_ADMIN_EMAIL_ID	VARCHAR2,
                    p_ADMIN_CONTACT_NO NUMBER
)
IS
                    v_admin_id NUMBER;
                    v_email_exists NUMBER;
                    v_contact_exists NUMBER;
                    EX_RAISE_EMAIL_ERROR EXCEPTION;
                    EX_RAISE_CONTACT_ERROR EXCEPTION;
                    INVALID_CONTACT_NO EXCEPTION;
                    INVALID_FIRST_NAME EXCEPTION;
BEGIN
-----------EXCEPTION QUERY----------------
   SELECT COUNT(*) INTO v_email_exists FROM admin WHERE ADMIN_email_id = p_ADMIN_EMAIL_ID;
   SELECT COUNT(*) INTO v_contact_exists FROM admin WHERE admin_contact_no = p_admin_contact_no;
    
    IF v_email_exists > 0 THEN
      RAISE  EX_RAISE_EMAIL_ERROR;
    END IF;
    IF v_contact_exists > 0 THEN
     RAISE  EX_RAISE_CONTACT_ERROR;
    END IF;
    IF p_admin_f_name is NULL   then
      RAISE INVALID_FIRST_NAME;
    END IF;
    IF p_admin_contact_no is NULL or  LENGTH(p_admin_contact_no) != 10  then
      RAISE INVALID_CONTACT_NO;
    END IF;

------------INSERTING PRIMARY KEY-------------
SELECT admin_id_seq.currVAL INTO v_admin_id FROM DUAL;
 
------------Insert new admin record into the database
    INSERT INTO admin (
                    ADMIN_ID,
                    ADMIN_F_NAME,
                    ADMIN_L_NAME,
                    ADMIN_DOB,
                    ADMIN_SINCE,
                    ADMIN_EMAIL_ID,
                    ADMIN_CONTACT_NO
    ) VALUES (
                    v_admin_id,
                    P_ADMIN_F_NAME,
                    P_ADMIN_L_NAME,
                    P_ADMIN_DOB,
                    sysdate,
                    P_ADMIN_EMAIL_ID,
                    P_ADMIN_CONTACT_NO
    );
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Admin ' || v_admin_id || ' onboarded successfully!');

EXCEPTION
    WHEN EX_RAISE_EMAIL_ERROR THEN
      dbms_output.put_line('Admin email id already exists. Please use another email id.');
    RETURN;
    WHEN EX_RAISE_CONTACT_ERROR THEN
      dbms_output.put_line('Admin CONTACT NO already exists. Please use another Contact no.');
    RETURN;
    WHEN INVALID_FIRST_NAME THEN
      dbms_output.put_line('YOU DID NOT ADD A FIRST NAME. PLEASE ADD A FIRST NAME');
    RETURN;
    WHEN INVALID_CONTACT_NO THEN
      dbms_output.put_line('INVALID CONTACT NUMBER. ADD A 10 DIGIT CONTACT NUMBER');
    RETURN;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
  
---------------------------------------------------------------
----------------------PROCEDURE SUPPLIER ONBOARDING------------
---------------------------------------------------------------
CREATE OR REPLACE PROCEDURE supplier_onboarding (
                        P_SUPPLIER_ID	NUMBER,
                        P_SUPPLIER_NAME	VARCHAR2,
                        P_SUPPLIER_CONTACT_NO	NUMBER,
                        P_SUPPLIER_EMAIL_ID	VARCHAR2,
                        P_SUPPLIER_ADDRESS_1	VARCHAR2,
                        P_SUPPLIER_ADDRESS_2	VARCHAR2,
                        P_SUPPLIER_CITY	VARCHAR2,
                        P_SUPPLIER_STATE	VARCHAR2,
                        P_SUPPLIER_ZIP	NUMBER,
                        P_SUPPLIER_SINCE	DATE
                        
)
IS
                        v_supplier_id NUMBER;
                        v_email_exists NUMBER;
                        v_contact_exists NUMBER;
                        EX_RAISE_EMAIL_ERROR EXCEPTION;
                        EX_RAISE_CONTACT_ERROR EXCEPTION;
                        INVALID_SUPPLIER_NAME EXCEPTION;
                        INVALID_CONTACT_NO EXCEPTION;
    
BEGIN
    -- Get the next supplier ID from the sequence
   SELECT COUNT(*) INTO v_email_exists FROM suppliers WHERE supplier_email_id = p_supplier_email_id;
   SELECT COUNT(*) INTO v_contact_exists FROM SUPPLIERS WHERE supplier_contact_no = p_supplier_contact_no;
    
 --------EXCEPTION QUERY---------
    IF v_email_exists > 0 THEN
      RAISE  EX_RAISE_EMAIL_ERROR;
    END IF;  
    IF v_contact_exists > 0 THEN
      RAISE  EX_RAISE_CONTACT_ERROR;
    END IF;
    IF p_supplier_name is NULL   then
      RAISE INVALID_SUPPLIER_NAME;
    END IF;   
    IF p_supplier_contact_no is NULL or  LENGTH(p_supplier_contact_no) != 10  then
      RAISE INVALID_CONTACT_NO;
    END IF;

------INSERTING PRIMARY KEY-------------
SELECT supplier_id_seq.currVAL INTO v_supplier_id FROM DUAL;

----------Insert new supplier record into the database----------
    INSERT INTO suppliers (
                        SUPPLIER_ID,
                        SUPPLIER_NAME,
                        SUPPLIER_CONTACT_NO,
                        SUPPLIER_EMAIL_ID,
                        SUPPLIER_ADDRESS_1,
                        SUPPLIER_ADDRESS_2,
                        SUPPLIER_CITY,
                        SUPPLIER_STATE,
                        SUPPLIER_ZIP,
                        SUPPLIER_SINCE
    ) VALUES (
                        v_supplier_id,
                        P_SUPPLIER_NAME,
                        P_SUPPLIER_CONTACT_NO,
                        P_SUPPLIER_EMAIL_ID,
                        P_SUPPLIER_ADDRESS_1,
                        P_SUPPLIER_ADDRESS_2,
                        P_SUPPLIER_CITY,
                        P_SUPPLIER_STATE,
                        P_SUPPLIER_ZIP,
                        SYSDATE
                        
    );
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Supplier ' || v_supplier_id || ' onboarded successfully!');
    
    EXCEPTION
    WHEN EX_RAISE_EMAIL_ERROR THEN
      dbms_output.put_line('Customer email id already exists. Please use another email id.');
    RETURN;
    WHEN EX_RAISE_CONTACT_ERROR THEN
      dbms_output.put_line('SUPPLIER CONTACT NO already exists. Please use another CONTACT NO.');
    RETURN;
    WHEN INVALID_SUPPLIER_NAME THEN
      dbms_output.put_line('YOU DID NOT ADD A SUPPLIER NAME. PLEASE ADD A SUPPLIER NAME');
    RETURN;
    WHEN INVALID_CONTACT_NO THEN
      dbms_output.put_line('INVALID CONTACT NUMBER. ADD A 10 DIGIT CONTACT NUMBER');
    RETURN;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

--------------------------------------------------------------------------------
------------------------PROCEDURE STOCK RETURN----------------------------------
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE STOCK_RETURNING (
                    P_PRODUCT_RETURN_ID NUMBER,
                    P_RETURN_NUMBER NUMBER,
                    P_RETURN_STOCK_ID NUMBER,
                    P_RETURN_QTY NUMBER,
                    P_RETURN_CUSTOMER_ID NUMBER,
                    P_RETURN_DATE DATE
                    )
IS
    V_PRODUCT_RETURN_ID NUMBER;
    V_RETURN_NUMBER NUMBER;           
    V_RETURN_STOCK_ID NUMBER;
    V_RETURN_QTY NUMBER;
    EX_RETURN_QTY_ERROR EXCEPTION;
    EX_RETURN_STOCK_ID_ERROR EXCEPTION;
    INVALID_CUSTOMER_ID EXCEPTION;
BEGIN

---------EXCEPTION QUERRY-------------
    SELECT COUNT(*) INTO V_RETURN_STOCK_ID FROM PRODUCT_SALE PS
                                           JOIN CUSTOMER_TRANSACTION CT ON PS.ORDER_NUMBER = CT.ORDER_NUMBER
                                           WHERE CT.ORDER_CUS_ID = P_RETURN_CUSTOMER_ID AND PS.SALE_STOCK_ID = P_RETURN_STOCK_ID;
    SELECT COUNT(*) INTO V_RETURN_QTY FROM PRODUCT_SALE PS
                                      JOIN CUSTOMER_TRANSACTION CT ON PS.ORDER_NUMBER = CT.ORDER_NUMBER
                                      WHERE CT.ORDER_CUS_ID = P_RETURN_CUSTOMER_ID AND PS.ORDER_QTY <=P_RETURN_QTY;
    
    IF V_RETURN_STOCK_ID = 0 THEN
      RAISE  EX_RETURN_STOCK_ID_ERROR;
    END IF;
    IF V_RETURN_QTY > 0 THEN
      RAISE  EX_RETURN_QTY_ERROR;
    END IF;
    IF P_RETURN_CUSTOMER_ID is NULL then
      RAISE INVALID_CUSTOMER_ID;
    END IF;
    
-----------INSERTING PRIMARY KEYS IN 2 TABLES---------
    SELECT RETURN_NUMBER_SEQ.currVAL INTO V_RETURN_NUMBER FROM DUAL;
    SELECT PRODUCT_RETURN_ID_SEQ.currVAL INTO V_PRODUCT_RETURN_ID FROM DUAL;
    
------Insert new RETURN PRODUCT SALE RECORD into the database--------
    INSERT INTO RETURN_PRODUCT_SALE (
                    PRODUCT_RETURN_ID,
                    RETURN_NUMBER,
                    RETURN_STOCK_ID,
                    RETURN_QTY
    )VALUES(
                    V_PRODUCT_RETURN_ID,
                    V_RETURN_NUMBER,
                    P_RETURN_STOCK_ID,
                    P_RETURN_QTY
    );

------Insert new RETURN TRANSACTION into the database--------    
    INSERT INTO RETURN_TRANSACTION (
                RETURN_NUMBER,
                RETURN_CUSTOMER_ID,
                RETURN_DATE
    )VALUES(
                V_RETURN_NUMBER,
                P_RETURN_CUSTOMER_ID,
                SYSDATE
    );
COMMIT;

    DBMS_OUTPUT.PUT_LINE('PRODUCT WITH' || V_PRODUCT_RETURN_ID || ' RETURNED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('RETURN TRANSACTION' || V_RETURN_NUMBER || ' TRANSACTED SUCCESSFULLY!');

EXCEPTION
    WHEN EX_RETURN_STOCK_ID_ERROR THEN
        dbms_output.put_line('STOCK RETURNED IS INVALID OR CUSTOMER IS INVALID .');
    RETURN;
    WHEN EX_RETURN_QTY_ERROR THEN
        dbms_output.put_line('RETURN QUANTITY MORE THAN PURCHASED QUANTITY.');
    RETURN;
    WHEN INVALID_CUSTOMER_ID THEN
        dbms_output.put_line('CUSTOMER DOES NOT EXIST');
    RETURN;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

----------------------------------------------------------------------------------------
------------------------PROCEDURE CUSTOMER TRANSACTION----------------------------------
----------------------------------------------------------------------------------------
create or replace procedure customer_transaction_process(
                P_ORDER_NUMBER	NUMBER,
                P_ORDER_CUS_ID	NUMBER,
                P_ORDER_DATE	DATE ,
                P_ORDER_PAYMENT_METHOD	VARCHAR2
                )
is 

  v_order_number  NUMBER ; -- replace with actual customer transaction ID
  v_prod_id        NUMBER;
  v_quantity       NUMBER;
  
  INVALID_Payment_Method exception;
INVALID_customer_id exception;
BEGIN

 
SELECT order_number_seq.currVAL INTO v_order_number FROM DUAL;

if P_ORDER_PAYMENT_METHOD is NULL   then
            raise INVALID_Payment_Method;
            END IF;
            
     if P_ORDER_CUS_ID is NULL   then
            raise INVALID_customer_id;
            END IF;       
    




    INSERT INTO customer_transaction (
                    ORDER_NUMBER,
                    ORDER_CUS_ID,
                    ORDER_DATE,
                    ORDER_PAYMENT_METHOD
    ) VALUES (
            v_order_number,
      P_ORDER_CUS_ID,
      P_ORDER_DATE,
      P_ORDER_PAYMENT_METHOD
    );
    
 COMMIT;
  
   DBMS_OUTPUT.PUT_LINE('Order ' ||  v_order_number || ' placed successfully!');
   
   EXCEPTION
   WHEN INVALID_Payment_Method THEN
    dbms_output.put_line('INVALID PAYMENT METHOD!');
    RETURN;
    WHEN INVALID_customer_id THEN
    dbms_output.put_line('INVALID CUSTOMER ID!');
    RETURN; 
   
END;


----------------------------------------------------------------------------------------
------------------------PROCEDURE CUSTOMER TRANSACTION----------------------------------
----------------------------------------------------------------------------------------

create or replace procedure order_product (
                            p_SALE_ID NUMBER,
                            p_ORDER_NUMBER NUMBER,
                            p_SALE_STOCK_ID NUMBER,
                            p_ORDER_QTY NUMBER

)

IS 

v_prod_id NUMBER;
v_quantity  NUMBER;
v_stock_quantity number;
V_STOCK_ID NUMBER;
V_ORDER_NUMBER NUMBER;
STOCK_INAPPROPRIATE EXCEPTION;
INVALID_ORDER_NUMBER EXCEPTION;
INVALID_STOCK_ID  EXCEPTION;
BEGIN
    
    SELECT sale_id_seq.currVAL INTO v_prod_id FROM DUAL;
     SELECT COUNT(*) INTO V_STOCK_ID FROM STOCK WHERE stock_id = p_SALE_STOCK_ID;
    SELECT stock_quantity INTO v_stock_quantity FROM stock WHERE stock_id=p_SALE_STOCK_ID;
   SELECT COUNT(*) INTO V_ORDER_NUMBER FROM CUSTOMER_TRANSACTION WHERE ORDER_NUMBER = p_ORDER_NUMBER;
    
     IF V_STOCK_ID > 0 THEN
      RAISE  INVALID_STOCK_ID;
    END IF;
    
      IF V_ORDER_NUMBER > 0 THEN
      RAISE  INVALID_ORDER_NUMBER;
    END IF;
    
    if v_stock_quantity < p_ORDER_QTY THEN
      RAISE  STOCK_INAPPROPRIATE;
    END IF;
    -- Insert product sale record into the database
    INSERT INTO product_sale (
      SALE_ID,
      ORDER_NUMBER,
      SALE_STOCK_ID,
      ORDER_QTY
    ) VALUES (
      v_prod_id,
      p_ORDER_NUMBER,
      p_SALE_STOCK_ID,
      p_ORDER_QTY
    );
    
 
  COMMIT;
  
   DBMS_OUTPUT.PUT_LINE('Product ' || p_SALE_STOCK_ID || ' ordered successfully!');
   
   EXCEPTION
    WHEN INVALID_ORDER_NUMBER THEN
    dbms_output.put_line('INVALID ORDER ID!');
    RETURN;
    WHEN INVALID_STOCK_ID THEN
    dbms_output.put_line('INVALID STOCK ID!');
    RETURN;
    WHEN STOCK_INAPPROPRIATE THEN
    dbms_output.put_line('ORDER QUANTITY GREATER THAN AVAILABLE STOCK!');
    RETURN;
  
END;


----------------------------------------------------------------------------------------
------------------------PROCEDURE SUPPLIER TRANSACTION----------------------------------
----------------------------------------------------------------------------------------
create or replace procedure Pro_Supplier_Transaction (
                                    P_SUPPLIER_TRANSACTION_ID	NUMBER,
                                    P_SUPPLIER_STOCK_ID	NUMBER,
                                    P_ADMIN_ID	NUMBER,
                                    P_SUPPLIER_TRANSACTION_DATE DATE,
                                    P_SUPPLY_QTY	NUMBER,
                                    P_SUPPLY_PRICE FLOAT,
                                    P_STOCK_ID NUMBER,
                                    P_STOCK_NAME	VarChar2,
                                    P_STOCK_QUANTITY NUMBER,
                                    P_REORDER_LEVEL NUMBER,
                                    P_STOCK_PRICE	FLOAT,
                                    P_SPECS	VarChar2,
                                    P_STOCK_SUPPLIER_ID NUMBER,
                                    P_STOCK_IN_DATE Date,
                                    P_MANUFACTURER_NAME	VarChar2
)

IS 

v_supplier_transaction_id NUMBER;
V_ADMIN_ID NUMBER;
V_STOCK_ID NUMBER;
INVALID_QTY EXCEPTION;
INVALID_PRICE EXCEPTION;
INVALID_ADMIN_ID EXCEPTION;
BEGIN
    
    SELECT supplier_transaction_id_seq.CURRVAL INTO v_supplier_transaction_id FROM DUAL;
    SELECT stock_id_seq.CURRVAL INTO V_STOCK_ID FROM DUAL;
    SELECT COUNT(*) INTO V_ADMIN_ID FROM ADMIN WHERE ADMIN_ID = P_ADMIN_ID;
    
  
      if P_SUPPLY_QTY is NULL OR P_SUPPLY_QTY = 0  then
            raise INVALID_QTY;
            END IF;
            
    if P_SUPPLY_PRICE is NULL OR P_SUPPLY_PRICE = 0  then
            raise INVALID_PRICE;
            END IF;
    if P_ADMIN_ID is NULL OR V_ADMIN_ID > 0  then
            raise INVALID_ADMIN_ID;
            END IF;
    -- Insert product sale record into the database
    INSERT INTO SUPPLIER_TRANSACTION (
                                    SUPPLIER_TRANSACTION_ID,
                                    SUPPLIER_STOCK_ID,
                                    ADMIN_ID,
                                    SUPPLIER_TRANSACTION_DATE,
                                    SUPPLY_QTY,
                                    SUPPLY_PRICE
                                    
    ) VALUES (
                                    P_SUPPLIER_TRANSACTION_ID,
                                    P_SUPPLIER_STOCK_ID,
                                    P_ADMIN_ID,
                                    P_SUPPLIER_TRANSACTION_DATE,
                                    P_SUPPLY_QTY,
                                    P_SUPPLY_PRICE
                                    
    );
    
 INSERT INTO STOCK (                STOCK_ID,
                                    STOCK_NAME,
                                    STOCK_QUANTITY,
                                    REORDER_LEVEL,
                                    STOCK_PRICE,
                                    SPECS,
                                    STOCK_SUPPLIER_ID,
                                    STOCK_IN_DATE,
                                    MANUFACTURER_NAME )
                                    VALUES
                                    (P_STOCK_ID,
                                    P_STOCK_NAME,
                                    P_STOCK_QUANTITY,
                                    P_REORDER_LEVEL,
                                    P_STOCK_PRICE,
                                    P_SPECS,
                                    P_STOCK_SUPPLIER_ID,
                                    P_STOCK_IN_DATE,
                                    P_MANUFACTURER_NAME);
  COMMIT;
  
   DBMS_OUTPUT.PUT_LINE('SUPPLY ' || v_supplier_transaction_id || ' STOCKED successfully!');
   DBMS_OUTPUT.PUT_LINE('SUPPLY ' || V_STOCK_ID || ' STOCKED successfully!');
   
   
   EXCEPTION
 WHEN INVALID_QTY THEN
    dbms_output.put_line('INVALID QUANTITY!');  
WHEN INVALID_PRICE THEN
    dbms_output.put_line('INVALID PRICE!');  
   WHEN INVALID_ADMIN_ID THEN
    dbms_output.put_line('INVALID ADMIN ID!');  
   

END;

--------------------------------------------------------------------------------
----------------------------PROCEDURE UPDATE STOCK-----------------------
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE update_stock (
    p_stock_id in stock.stock_id%type,
    p_stock_name in stock.stock_name%type,
    p_stock_quantity in stock.stock_quantity%type,
    p_reorder_level in stock.reorder_level%type,
    p_stock_price in stock.stock_price%type,
    p_stock_supplier_id in stock.stock_supplier_id%type,
    p_stock_in_date in stock.stock_in_date%type
)
IS
    v_stock_quantity NUMBER;
    v_stock_price NUMBER;
    v_stock_name NUMBER;
    v_stock_supplier_id NUMBER;
    v_stock_in_date NUMBER;
    EX_RAISE_INVALID_STOCK_QUANTITY EXCEPTION;
    EX_RAISE_INVALID_STOCK_PRICE EXCEPTION;
    EX_RAISE_INVALID_STOCK_NAME EXCEPTION;
    EX_RAISE_INVALID_STOCK_SUPPLIER_ID EXCEPTION;
    EX_RAISE_INVALID_STOCK_IN_DATE EXCEPTION;
    
BEGIN
-----------EXCEPTION QUERY----------------
SELECT COUNT(*) INTO V_STOCK_QUANTITY FROM STOCK WHERE stock_quantity = p_stock_quantity;
SELECT COUNT(*) INTO V_STOCK_PRICE FROM STOCK WHERE stock_price = p_stock_price;
SELECT COUNT(*) INTO V_STOCK_NAME FROM STOCK WHERE stock_name = p_stock_name;
SELECT COUNT(*) INTO V_STOCK_SUPPLIER_ID FROM STOCK WHERE stock_supplier_id = p_stock_supplier_id;
SELECT COUNT(*) INTO V_STOCK_IN_DATE FROM STOCK WHERE stock_in_date = p_stock_in_date;
IF V_STOCK_quantity = NULL THEN
      RAISE  EX_RAISE_INVALID_STOCK_QUANTITY;
    END IF;
IF V_STOCK_price = NULL THEN
      RAISE  EX_RAISE_INVALID_STOCK_PRICE;
    END IF;
IF V_STOCK_name = NULL THEN
      RAISE  EX_RAISE_INVALID_STOCK_name;
    END IF;
IF V_STOCK_supplier_id = NULL THEN
      RAISE  EX_RAISE_INVALID_STOCK_supplier_id;
    END IF;
IF V_STOCK_in_date = NULL THEN
      RAISE  EX_RAISE_INVALID_STOCK_in_date;
    END IF;
-----------UPDATING STOCK VALUE----------------
UPDATE STOCK SET stock_name = p_stock_name,
stock_quantity = p_stock_quantity,
reorder_level = p_reorder_level,
stock_price = p_stock_price,
stock_supplier_id = p_stock_supplier_id,
stock_in_date = p_stock_in_date
where stock_id = p_stock_id; 
COMMIT;

EXCEPTION
      WHEN EX_RAISE_INVALID_STOCK_QUANTITY THEN
      dbms_output.put_line('stock_quantity cant be NULL. Please use another value.');
      RETURN;
      WHEN EX_RAISE_INVALID_STOCK_PRICE THEN
      dbms_output.put_line('stock_price cant be NULL. Please use another value.');
      RETURN;
      WHEN EX_RAISE_INVALID_STOCK_NAME THEN
      dbms_output.put_line('stock_name cant be NULL. Please use another value.');
      RETURN;
      WHEN EX_RAISE_INVALID_STOCK_SUPPLIER_ID THEN
      dbms_output.put_line('stock_supplier_id cant be NULL. Please use another value.');
      RETURN;
      WHEN EX_RAISE_INVALID_STOCK_IN_DATE THEN
      dbms_output.put_line('stock_in_date cant be NULL. Please use another value.');
      RETURN;
      END;
      /

-----------------------------------------------------------------------------------
----------------------------PROCEDURE DELETE CUSTOMER------------------------------
-----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE delete_customer
               ( p_customer_id number)
               
               is
    V_CUSTOMER_ID NUMBER;
   INVALID_CUSTOMER_ID EXCEPTION;             
               begin 
               SELECT COUNT(*) INTO V_CUSTOMER_ID FROM CUSTOMER WHERE CUSTOMER_ID = P_CUSTOMER_ID;
               if  V_CUSTOMER_ID > 0  then
            raise INVALID_CUSTOMER_ID;
            END IF;
               
               delete from customer where customer_id = p_customer_id;
               COMMIT;
               DBMS_OUTPUT.PUT_LINE('CUSTOMER ' || V_CUSTOMER_ID || ' DELETED SUCCESSFULLY!');
    EXCEPTION
    WHEN INVALID_CUSTOMER_ID THEN
    DBMS_OUTPUT.PUT_LINE('CUSTOMER ' || V_CUSTOMER_ID || ' DOES NOT EXIST! CANNOT DELETE');
               end;

-----------------------------------------------------------------------------------
----------------------------PROCEDURE DELETE ADMIN---------------------------------
-----------------------------------------------------------------------------------               

CREATE OR REPLACE PROCEDURE delete_admin
               ( p_admin_id number)
               
               is
               
        V_ADMIN_ID NUMBER;
        INVALID_ADMIN_ID EXCEPTION;    
               begin 
               SELECT COUNT(*) INTO V_ADMIN_ID FROM ADMIN WHERE ADMIN_ID = p_admin_id;
               if  V_ADMIN_ID > 0  then
            raise INVALID_ADMIN_ID;
            END IF;
            
               delete from admin where admin_id = p_admin_id;
    EXCEPTION
    WHEN INVALID_ADMIN_ID THEN
    DBMS_OUTPUT.PUT_LINE('ADMIN ' || V_ADMIN_ID || ' DOES NOT EXIST! CANNOT DELETE');
               end;
  
-----------------------------------------------------------------------------------
----------------------------PROCEDURE DELETE SUPPLIER------------------------------
-----------------------------------------------------------------------------------
               

CREATE OR REPLACE PROCEDURE delete_supplier
               ( p_supplier_id number)
               
               is
         V_SUPPLIER_ID NUMBER;
        INVALID_SUPPLIER_ID EXCEPTION;       
               begin 
              SELECT COUNT(*) INTO V_SUPPLIER_ID FROM SUPPLIERS WHERE SUPPLIER_ID = p_supplier_id;
               if  V_SUPPLIER_ID > 0  then
            raise INVALID_SUPPLIER_ID;
            END IF; 
               delete from suppliers where supplier_id = p_supplier_id;
           EXCEPTION
    WHEN INVALID_SUPPLIER_ID THEN
    DBMS_OUTPUT.PUT_LINE('SUPPLIER ' || V_SUPPLIER_ID || ' DOES NOT EXIST! CANNOT DELETE');     
               end;

-----------------------------------------------------------------------------------
----------------------------PROCEDURE DELETE STOCK---------------------------------
-----------------------------------------------------------------------------------               

CREATE OR REPLACE PROCEDURE delete_stock
               ( p_stock_id number)
               
               is
    V_STOCK_ID NUMBER;
    INVALID_STOCK_ID EXCEPTION;
               begin 
                SELECT COUNT(*) INTO V_STOCK_ID FROM STOCK WHERE STOCK_ID = p_stock_id;
               if  V_STOCK_ID > 0  then
            raise INVALID_STOCK_ID;
            END IF;
               delete from stock where stock_id = p_stock_id;
                EXCEPTION
    WHEN INVALID_STOCK_ID THEN
    DBMS_OUTPUT.PUT_LINE('STOCK ' || V_STOCK_ID || ' DOES NOT EXIST! CANNOT DELETE');    
               end;

