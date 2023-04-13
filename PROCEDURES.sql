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
