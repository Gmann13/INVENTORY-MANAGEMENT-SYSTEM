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
