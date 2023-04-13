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
SET SERVEROUTPUT ON;
create sequence admin_id_seq
START WITH 11
INCREMENT BY 1
MAXVALUE 99
NOCYCLE
CACHE 20;


---------------------------------------------------------------
----------------------SEQUENCE FOR SUPPLIER ID-----------------
---------------------------------------------------------------

SELECT * FROM SUPPLIERS;
drop sequence supplier_id_seq;
create sequence supplier_id_seq
  START WITH 16
  INCREMENT BY 1
  MAXVALUE 999
  NOCYCLE
  CACHE 20;
  
--------------------------------------------------------------------------------
----------------------------PROCEDURE CUSTOMER ONBOARDING-----------------------
--------------------------------------------------------------------------------

SET SERVEROUTPUT ON
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
    -- Get the next customer ID from the sequence
   SELECT customer_id_seq.currVAL INTO v_customer_id FROM DUAL;
    SELECT COUNT(*) INTO v_email_exists FROM customer WHERE cus_email_id = p_cus_email_id;
    
    SELECT COUNT(*) INTO v_contact_exists FROM customer WHERE cus_contact_no = p_cus_contact_no;
    
    
    
    IF v_email_exists > 0 THEN
      RAISE  EX_RAISE_EMAIL_ERROR;
    END IF;
    
     IF v_contact_exists > 0 THEN
      RAISE  EX_RAISE_CONTACT_ERROR;
    END IF;
    
     if p_cus_f_name is NULL   then
            raise INVALID_FIRST_NAME;
            END IF;
    if p_cus_contact_no is NULL or  LENGTH(p_cus_contact_no) != 10  then
            raise INVALID_CONTACT_NO;
            END IF;
            
    if p_cus_dob is NULL or ((sysdate - p_cus_dob)/365) < 13 then
            raise INVALID_DATE_OF_BIRTH;
            END IF;
            
    -- Insert new customer record into the database
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
    -- Get the next customer ID from the sequence
   SELECT admin_id_seq.currVAL INTO v_admin_id FROM DUAL;
   SELECT COUNT(*) INTO v_email_exists FROM admin WHERE ADMIN_email_id = p_ADMIN_EMAIL_ID;
    
    SELECT COUNT(*) INTO v_contact_exists FROM admin WHERE admin_contact_no = p_admin_contact_no;
    
    IF v_email_exists > 0 THEN
      RAISE  EX_RAISE_EMAIL_ERROR;
    END IF;

     IF v_contact_exists > 0 THEN
      RAISE  EX_RAISE_CONTACT_ERROR;
    END IF;
    
     if p_admin_f_name is NULL   then
            raise INVALID_FIRST_NAME;
            END IF;
    if p_admin_contact_no is NULL or  LENGTH(p_admin_contact_no) != 10  then
            raise INVALID_CONTACT_NO;
            END IF;
            
    -- Insert new customer record into the database
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
    -- Get the next customer ID from the sequence
   SELECT COUNT(*) INTO v_email_exists FROM suppliers WHERE supplier_email_id = p_supplier_email_id;
    
    SELECT COUNT(*) INTO v_contact_exists FROM SUPPLIERS WHERE supplier_contact_no = p_supplier_contact_no;
    
    
    IF v_email_exists > 0 THEN
      RAISE  EX_RAISE_EMAIL_ERROR;
    END IF;
    
     IF v_contact_exists > 0 THEN
      RAISE  EX_RAISE_CONTACT_ERROR;
    END IF;
    
     if p_supplier_name is NULL   then
            raise INVALID_SUPPLIER_NAME;
            END IF;
            
    if p_supplier_contact_no is NULL or  LENGTH(p_supplier_contact_no) != 10  then
            raise INVALID_CONTACT_NO;
            END IF;

SELECT supplier_id_seq.currVAL INTO v_supplier_id FROM DUAL;
   
            
    -- Insert new customer record into the database
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

