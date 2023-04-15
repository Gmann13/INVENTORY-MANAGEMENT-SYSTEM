CREATE OR REPLACE EDITIONABLE PACKAGE CUSTOMER_PKG
AS

PROCEDURE INSERT_CUSTOMER
    (
    p_customer_id IN CUSTOMER.customer_id%TYPE,
    p_cus_f_name IN CUSTOMER.cus_f_name%TYPE,
    p_cus_l_name IN CUSTOMER.cus_l_name%TYPE,
    p_cus_dob IN CUSTOMER.cus_dob%TYPE,
    p_cus_since IN  CUSTOMER.cus_since%TYPE,
    p_cus_gender  IN CUSTOMER.cus_gender%TYPE,
    p_cus_contact_no IN CUSTOMER.cus_contact_no%TYPE,
    p_cus_alternate_no IN CUSTOMER.cus_alternate_no%TYPE,
    p_cus_email_id IN CUSTOMER.cus_email_id%TYPE,
    p_cus_address_1 IN CUSTOMER.cus_address_1%TYPE,
    p_cus_address_2 IN CUSTOMER.cus_address_2%TYPE,
    p_cus_city IN CUSTOMER.cus_city%TYPE,
    p_cus_state IN CUSTOMER.cus_state%TYPE,
    p_cus_country IN CUSTOMER.cus_country%TYPE,
    p_cus_zip IN CUSTOMER.cus_zip%TYPE);

PROCEDURE UPDATE_CUSTOMER(
    p_customer_id IN CUSTOMER.customer_id%TYPE,
    p_cus_f_name IN CUSTOMER.cus_f_name%TYPE,
    p_cus_l_name IN CUSTOMER.cus_l_name%TYPE,
    p_cus_dob IN CUSTOMER.cus_dob%TYPE,
    p_cus_since IN CUSTOMER.cus_since%TYPE,
    p_cus_gender  IN CUSTOMER.cus_gender%TYPE,
    p_cus_contact_no IN CUSTOMER.cus_contact_no%TYPE,
    p_cus_alternate_no IN CUSTOMER.cus_alternate_no%TYPE,
    p_cus_email_id IN CUSTOMER.cus_email_id%TYPE,
    p_cus_address_1 IN CUSTOMER.cus_address_1%TYPE,
    p_cus_address_2 IN CUSTOMER.cus_address_2%TYPE,
    p_cus_city IN CUSTOMER.cus_city%TYPE,
    p_cus_state IN CUSTOMER.cus_state%TYPE,
    p_cus_country IN CUSTOMER.cus_country%TYPE,
    p_cus_zip IN CUSTOMER.cus_zip%TYPE);
    
PROCEDURE DELETE_CUSTOMER
               ( p_customer_id IN CUSTOMER.customer_id%TYPE);

END CUSTOMER_PKG;

CREATE OR REPLACE EDITIONABLE PACKAGE ADMIN_PKG
AS
PROCEDURE INSERT_ADMIN
(
                    p_ADMIN_ID IN ADMIN.ADMIN_ID%TYPE,
                    p_ADMIN_F_NAME IN ADMIN.ADMIN_F_NAME%TYPE,
                    p_ADMIN_L_NAME IN ADMIN.ADMIN_L_NAME%TYPE,
                    p_ADMIN_DOB IN ADMIN.ADMIN_DOB%TYPE,
                    p_ADMIN_SINCE	IN ADMIN.ADMIN_SINCE%TYPE,
                    p_ADMIN_EMAIL_ID	IN ADMIN.ADMIN_EMAIL_ID%TYPE,
                    p_ADMIN_CONTACT_NO IN ADMIN.ADMIN_CONTACT_NO%TYPE
);

PROCEDURE UPDATE_ADMIN
(
                    p_ADMIN_ID IN ADMIN.ADMIN_ID%TYPE,
                    p_ADMIN_F_NAME IN ADMIN.ADMIN_F_NAME%TYPE,
                    p_ADMIN_L_NAME IN ADMIN.ADMIN_L_NAME%TYPE,
                    p_ADMIN_DOB IN ADMIN.ADMIN_DOB%TYPE,
                    p_ADMIN_SINCE	IN ADMIN.ADMIN_SINCE%TYPE,
                    p_ADMIN_EMAIL_ID	IN ADMIN.ADMIN_EMAIL_ID%TYPE,
                    p_ADMIN_CONTACT_NO IN ADMIN.ADMIN_CONTACT_NO%TYPE
);

PROCEDURE DELETE_ADMIN
(p_ADMIN_id IN ADMIN.ADMIN_id%TYPE);


END ADMIN_PKG;


CREATE OR REPLACE PACKAGE CUSTOMER_TRANSACTION_PKG 
AS
PROCEDURE CUSTOMER_TRANSACTION_PRO
(               P_ORDER_NUMBER	IN CUSTOMER_TRANSACTION.ORDER_NUMBER%TYPE,
                P_ORDER_CUS_ID	IN CUSTOMER_TRANSACTION.ORDER_CUS_ID%TYPE,
                P_ORDER_DATE	IN CUSTOMER_TRANSACTION.ORDER_DATE%TYPE ,
                P_ORDER_PAYMENT_METHOD	IN CUSTOMER_TRANSACTION.ORDER_PAYMENT_METHOD%TYPE
);

PROCEDURE CUSTOMER_PRODUCT
(                           p_SALE_ID NUMBER,
                            p_ORDER_NUMBER NUMBER,
                            p_SALE_STOCK_ID NUMBER,
                            p_ORDER_QTY NUMBER
                            
);

END CUSTOMER_TRANSACTION_PKG ;
SELECT * FROM SUPPLIERS;

CREATE OR REPLACE EDITIONABLE PACKAGE SUPPLIER_PKG
AS
PROCEDURE INSERT_SUPPLIERS
(
                        P_SUPPLIER_ID IN SUPPLIERS.SUPPLIER_ID%TYPE,
                        P_SUPPLIER_NAME IN SUPPLIERS.SUPPLIER_NAME%TYPE,
                        P_SUPPLIER_CONTACT_NO IN SUPPLIERS.SUPPLIER_CONTACT_NO%TYPE,
                        P_SUPPLIER_EMAIL_ID IN SUPPLIERS.SUPPLIER_EMAIL_ID%TYPE,
                        P_SUPPLIER_ADDRESS_1  IN SUPPLIERS.SUPPLIER_ADDRESS_1%TYPE,
                        P_SUPPLIER_ADDRESS_2 IN SUPPLIERS.SUPPLIER_ADDRESS_2%TYPE,
                        P_SUPPLIER_CITY IN SUPPLIERS.SUPPLIER_CITY%TYPE,
                        P_SUPPLIER_STATE IN SUPPLIERS.SUPPLIER_STATE%TYPE,
                        P_SUPPLIER_ZIP IN SUPPLIERS.SUPPLIER_ZIP%TYPE,
                        P_SUPPLIER_SINCE IN SUPPLIERS.SUPPLIER_SINCE%TYPE
);

PROCEDURE UPDATE_SUPPLIERS
(
                    
                        P_SUPPLIER_ID IN SUPPLIERS.SUPPLIER_ID%TYPE,
                        P_SUPPLIER_NAME IN SUPPLIERS.SUPPLIER_NAME%TYPE,
                        P_SUPPLIER_CONTACT_NO IN SUPPLIERS.SUPPLIER_CONTACT_NO%TYPE,
                        P_SUPPLIER_EMAIL_ID IN SUPPLIERS.SUPPLIER_EMAIL_ID%TYPE,
                        P_SUPPLIER_ADDRESS_1  IN SUPPLIERS.SUPPLIER_ADDRESS_1%TYPE,
                        P_SUPPLIER_ADDRESS_2 IN SUPPLIERS.SUPPLIER_ADDRESS_2%TYPE,
                        P_SUPPLIER_CITY IN SUPPLIERS.SUPPLIER_CITY%TYPE,
                        P_SUPPLIER_STATE IN SUPPLIERS.SUPPLIER_STATE%TYPE,
                        P_SUPPLIER_ZIP IN SUPPLIERS.SUPPLIER_ZIP%TYPE,
                        P_SUPPLIER_SINCE IN SUPPLIERS.SUPPLIER_SINCE%TYPE
);

PROCEDURE DELETE_SUPPLIERS
(p_SUPPLIER_id IN SUPPLIERS.SUPPLIER_id%TYPE);


END SUPPLIER_PKG;

----------STOCK_PACKAGE-----------
CREATE OR REPLACE EDITIONABLE PACKAGE  STOCK_PKG
AS 

PROCEDURE UPDATE_STOCK
(
P_STOCK_ID IN STOCK.STOCK_ID%TYPE,
P_STOCK_NAME IN STOCK.STOCK_NAME%TYPE,
P_STOCK_QUANTITY IN STOCK.STOCK_QUANTITY%TYPE,
P_REORDER_LEVEL IN STOCK.REORDER_LEVEL%TYPE,
P_STOCK_PRICE IN STOCK.STOCK_PRICE%TYPE,
P_SPECS IN STOCK.SPECS%TYPE,
P_STOCK_SUPPLIER_ID IN STOCK.STOCK_SUPPLIER_ID%TYPE  , 
P_STOCK_IN_DATE IN STOCK.STOCK_IN_DATE%TYPE   ,
P_MANUFACTURER_NAME  IN STOCK.MANUFACTURER_NAME%TYPE  );

PROCEDURE DELETE_STOCK
(
P_STOCK_ID IN STOCK.STOCK_ID%TYPE); 

END STOCK_PKG;


--------STOCK_BODY--------------


CREATE OR REPLACE EDITIONABLE PACKAGE BODY  STOCK_PKG
AS 
PROCEDURE UPDATE_STOCK
(
P_STOCK_ID IN STOCK.STOCK_ID%TYPE,
P_STOCK_NAME IN STOCK.STOCK_NAME%TYPE,
P_STOCK_QUANTITY IN STOCK.STOCK_QUANTITY%TYPE,
P_REORDER_LEVEL IN STOCK.REORDER_LEVEL%TYPE,
P_STOCK_PRICE IN STOCK.STOCK_PRICE%TYPE,
P_SPECS IN STOCK.SPECS%TYPE,
P_STOCK_SUPPLIER_ID IN STOCK.STOCK_SUPPLIER_ID%TYPE  , 
P_STOCK_IN_DATE IN STOCK.STOCK_IN_DATE%TYPE   ,
P_MANUFACTURER_NAME IN STOCK.MANUFACTURER_NAME%TYPE  )

AS
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
PROCEDURE DELETE_STOCK
(
P_STOCK_ID IN STOCK.STOCK_ID%TYPE)

AS
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
    DBMS_OUTPUT.PUT_LINE('STOCK ' ||  V_STOCK_ID || ' DOES NOT EXIST! CANNOT DELETE');    
               end;
      
END STOCK_PKG;




------------------------------SUPPLIER PACKAGE-------------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE SUPPLIER_PKG
AS
PROCEDURE INSERT_SUPPLIERS
(
                        P_SUPPLIER_ID IN SUPPLIERS.SUPPLIER_ID%TYPE,
                        P_SUPPLIER_NAME IN SUPPLIERS.SUPPLIER_NAME%TYPE,
                        P_SUPPLIER_CONTACT_NO IN SUPPLIERS.SUPPLIER_CONTACT_NO%TYPE,
                        P_SUPPLIER_EMAIL_ID IN SUPPLIERS.SUPPLIER_EMAIL_ID%TYPE,
                        P_SUPPLIER_ADDRESS_1  IN SUPPLIERS.SUPPLIER_ADDRESS_1%TYPE,
                        P_SUPPLIER_ADDRESS_2 IN SUPPLIERS.SUPPLIER_ADDRESS_2%TYPE,
                        P_SUPPLIER_CITY IN SUPPLIERS.SUPPLIER_CITY%TYPE,
                        P_SUPPLIER_STATE IN SUPPLIERS.SUPPLIER_STATE%TYPE,
                        P_SUPPLIER_ZIP IN SUPPLIERS.SUPPLIER_ZIP%TYPE,
                        P_SUPPLIER_SINCE IN SUPPLIERS.SUPPLIER_SINCE%TYPE
);


PROCEDURE UPDATE_SUPPLIERS
(
                    
                        P_SUPPLIER_ID IN SUPPLIERS.SUPPLIER_ID%TYPE,
                        P_SUPPLIER_NAME IN SUPPLIERS.SUPPLIER_NAME%TYPE,
                        P_SUPPLIER_CONTACT_NO IN SUPPLIERS.SUPPLIER_CONTACT_NO%TYPE,
                        P_SUPPLIER_EMAIL_ID IN SUPPLIERS.SUPPLIER_EMAIL_ID%TYPE,
                        P_SUPPLIER_ADDRESS_1  IN SUPPLIERS.SUPPLIER_ADDRESS_1%TYPE,
                        P_SUPPLIER_ADDRESS_2 IN SUPPLIERS.SUPPLIER_ADDRESS_2%TYPE,
                        P_SUPPLIER_CITY IN SUPPLIERS.SUPPLIER_CITY%TYPE,
                        P_SUPPLIER_STATE IN SUPPLIERS.SUPPLIER_STATE%TYPE,
                        P_SUPPLIER_ZIP IN SUPPLIERS.SUPPLIER_ZIP%TYPE,
                        P_SUPPLIER_SINCE IN SUPPLIERS.SUPPLIER_SINCE%TYPE
);


PROCEDURE DELETE_SUPPLIERS
(p_SUPPLIER_id IN SUPPLIERS.SUPPLIER_id%TYPE);


END SUPPLIER_PKG;

CREATE OR REPLACE EDITIONABLE PACKAGE BODY SUPPLIER_PKG
AS 
PROCEDURE INSERT_SUPPLIERS
(
                        P_SUPPLIER_ID IN SUPPLIERS.SUPPLIER_ID%TYPE,
                        P_SUPPLIER_NAME IN SUPPLIERS.SUPPLIER_NAME%TYPE,
                        P_SUPPLIER_CONTACT_NO IN SUPPLIERS.SUPPLIER_CONTACT_NO%TYPE,
                        P_SUPPLIER_EMAIL_ID IN SUPPLIERS.SUPPLIER_EMAIL_ID%TYPE,
                        P_SUPPLIER_ADDRESS_1  IN SUPPLIERS.SUPPLIER_ADDRESS_1%TYPE,
                        P_SUPPLIER_ADDRESS_2 IN SUPPLIERS.SUPPLIER_ADDRESS_2%TYPE,
                        P_SUPPLIER_CITY IN SUPPLIERS.SUPPLIER_CITY%TYPE,
                        P_SUPPLIER_STATE IN SUPPLIERS.SUPPLIER_STATE%TYPE,
                        P_SUPPLIER_ZIP IN SUPPLIERS.SUPPLIER_ZIP%TYPE,
                        P_SUPPLIER_SINCE IN SUPPLIERS.SUPPLIER_SINCE%TYPE
)

AS
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
END INSERT_SUPPLIERS;

PROCEDURE UPDATE_SUPPLIERS
(
                    
                        P_SUPPLIER_ID IN SUPPLIERS.SUPPLIER_ID%TYPE,
                        P_SUPPLIER_NAME IN SUPPLIERS.SUPPLIER_NAME%TYPE,
                        P_SUPPLIER_CONTACT_NO IN SUPPLIERS.SUPPLIER_CONTACT_NO%TYPE,
                        P_SUPPLIER_EMAIL_ID IN SUPPLIERS.SUPPLIER_EMAIL_ID%TYPE,
                        P_SUPPLIER_ADDRESS_1  IN SUPPLIERS.SUPPLIER_ADDRESS_1%TYPE,
                        P_SUPPLIER_ADDRESS_2 IN SUPPLIERS.SUPPLIER_ADDRESS_2%TYPE,
                        P_SUPPLIER_CITY IN SUPPLIERS.SUPPLIER_CITY%TYPE,
                        P_SUPPLIER_STATE IN SUPPLIERS.SUPPLIER_STATE%TYPE,
                        P_SUPPLIER_ZIP IN SUPPLIERS.SUPPLIER_ZIP%TYPE,
                        P_SUPPLIER_SINCE IN SUPPLIERS.SUPPLIER_SINCE%TYPE
)

AS
v_supplier_id number;
v_supplier_name varchar2(20);
v_supplier_contact_no number;
INVALID_NAME EXCEPTION;
INVALID_CONTACT_NO EXCEPTION;

BEGIN
    IF v_supplier_name is NULL then
      RAISE INVALID_NAME;
    END IF;
    IF v_supplier_contact_no is NULL or  LENGTH(p_supplier_contact_no) != 10  then
       RAISE INVALID_CONTACT_NO;
    END IF;        

UPDATE SUPPLIERS SET SUPPLIER_NAME = P_SUPPLIER_NAME,
                     SUPPLIER_CONTACT_NO = P_SUPPLIER_CONTACT_NO,
                     SUPPLIER_EMAIL_ID = P_SUPPLIER_EMAIL_ID,
                     SUPPLIER_ADDRESS_1 = P_SUPPLIER_ADDRESS_1,
                     SUPPLIER_ADDRESS_2 = P_SUPPLIER_ADDRESS_2,
                     SUPPLIER_CITY = P_SUPPLIER_CITY,
                     SUPPLIER_STATE = P_SUPPLIER_STATE,
                     SUPPLIER_ZIP = P_SUPPLIER_ZIP,
                     SUPPLIER_SINCE = P_SUPPLIER_SINCE
    WHERE SUPPLIER_ID = P_SUPPLIER_ID;
COMMIT;
            DBMS_OUTPUT.PUT_LINE('supplier ' || v_supplier_id || ' updated successfully!');
        
        EXCEPTION
        WHEN INVALID_NAME THEN
            dbms_output.put_line('YOU DID NOT ADD A FIRST NAME. PLEASE ADD A FIRST NAME');
        RETURN;
        WHEN INVALID_CONTACT_NO THEN
            dbms_output.put_line('INVALID CONTACT NUMBER. ADD A 10 DIGIT CONTACT NUMBER');
        RETURN;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);

END UPDATE_SUPPLIERS;

PROCEDURE DELETE_SUPPLIERS
(p_SUPPLIER_id IN SUPPLIERS.SUPPLIER_id%TYPE)

AS
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
               end DELETE_SUPPLIERS;

END SUPPLIER_PKG;

---------------------------------SUPPLIER PACKAGE BODY-------------------------------------
CREATE OR REPLACE EDITIONABLE PACKAGE BODY SUPPLIER_PKG
AS 
PROCEDURE INSERT_SUPPLIERS
(
                        P_SUPPLIER_ID IN SUPPLIERS.SUPPLIER_ID%TYPE,
                        P_SUPPLIER_NAME IN SUPPLIERS.SUPPLIER_NAME%TYPE,
                        P_SUPPLIER_CONTACT_NO IN SUPPLIERS.SUPPLIER_CONTACT_NO%TYPE,
                        P_SUPPLIER_EMAIL_ID IN SUPPLIERS.SUPPLIER_EMAIL_ID%TYPE,
                        P_SUPPLIER_ADDRESS_1  IN SUPPLIERS.SUPPLIER_ADDRESS_1%TYPE,
                        P_SUPPLIER_ADDRESS_2 IN SUPPLIERS.SUPPLIER_ADDRESS_2%TYPE,
                        P_SUPPLIER_CITY IN SUPPLIERS.SUPPLIER_CITY%TYPE,
                        P_SUPPLIER_STATE IN SUPPLIERS.SUPPLIER_STATE%TYPE,
                        P_SUPPLIER_ZIP IN SUPPLIERS.SUPPLIER_ZIP%TYPE,
                        P_SUPPLIER_SINCE IN SUPPLIERS.SUPPLIER_SINCE%TYPE
)

AS
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
END INSERT_SUPPLIERS;

PROCEDURE UPDATE_SUPPLIERS
(
                    
                        P_SUPPLIER_ID IN SUPPLIERS.SUPPLIER_ID%TYPE,
                        P_SUPPLIER_NAME IN SUPPLIERS.SUPPLIER_NAME%TYPE,
                        P_SUPPLIER_CONTACT_NO IN SUPPLIERS.SUPPLIER_CONTACT_NO%TYPE,
                        P_SUPPLIER_EMAIL_ID IN SUPPLIERS.SUPPLIER_EMAIL_ID%TYPE,
                        P_SUPPLIER_ADDRESS_1  IN SUPPLIERS.SUPPLIER_ADDRESS_1%TYPE,
                        P_SUPPLIER_ADDRESS_2 IN SUPPLIERS.SUPPLIER_ADDRESS_2%TYPE,
                        P_SUPPLIER_CITY IN SUPPLIERS.SUPPLIER_CITY%TYPE,
                        P_SUPPLIER_STATE IN SUPPLIERS.SUPPLIER_STATE%TYPE,
                        P_SUPPLIER_ZIP IN SUPPLIERS.SUPPLIER_ZIP%TYPE,
                        P_SUPPLIER_SINCE IN SUPPLIERS.SUPPLIER_SINCE%TYPE
)

AS
v_supplier_id number;
v_supplier_name varchar2(20);
v_supplier_contact_no number;
INVALID_NAME EXCEPTION;
INVALID_CONTACT_NO EXCEPTION;

BEGIN
    IF v_supplier_name is NULL then
      RAISE INVALID_NAME;
    END IF;
    IF v_supplier_contact_no is NULL or  LENGTH(p_supplier_contact_no) != 10  then
       RAISE INVALID_CONTACT_NO;
    END IF;        

UPDATE SUPPLIERS SET SUPPLIER_NAME = P_SUPPLIER_NAME,
                     SUPPLIER_CONTACT_NO = P_SUPPLIER_CONTACT_NO,
                     SUPPLIER_EMAIL_ID = P_SUPPLIER_EMAIL_ID,
                     SUPPLIER_ADDRESS_1 = P_SUPPLIER_ADDRESS_1,
                     SUPPLIER_ADDRESS_2 = P_SUPPLIER_ADDRESS_2,
                     SUPPLIER_CITY = P_SUPPLIER_CITY,
                     SUPPLIER_STATE = P_SUPPLIER_STATE,
                     SUPPLIER_ZIP = P_SUPPLIER_ZIP,
                     SUPPLIER_SINCE = P_SUPPLIER_SINCE
    WHERE SUPPLIER_ID = P_SUPPLIER_ID;
COMMIT;
            DBMS_OUTPUT.PUT_LINE('supplier ' || v_supplier_id || ' updated successfully!');
        
        EXCEPTION
        WHEN INVALID_NAME THEN
            dbms_output.put_line('YOU DID NOT ADD A FIRST NAME. PLEASE ADD A FIRST NAME');
        RETURN;
        WHEN INVALID_CONTACT_NO THEN
            dbms_output.put_line('INVALID CONTACT NUMBER. ADD A 10 DIGIT CONTACT NUMBER');
        RETURN;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);

END UPDATE_SUPPLIERS;

PROCEDURE DELETE_SUPPLIERS
(p_SUPPLIER_id IN SUPPLIERS.SUPPLIER_id%TYPE)

AS
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
               end DELETE_SUPPLIERS;

END SUPPLIER_PKG;
