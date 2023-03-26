--CLEANUP SCRIPT
set serveroutput on
declare
    v_table_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start schema cleanup');
   for i in (   select 'CUSTOMER' table_name from dual union all
                select 'CUSTOMER_TRANSACTION' table_name from dual union all
                select 'STOCK' table_name from dual union all
                select 'PRODUCT_SALE' table_name from dual union all
                select 'ADMIN' table_name from dual union all
                select 'SUPPLIER_TRANSACTION' table_name from dual union all
                select 'RETURN_TRANSACTION' table_name from dual union all
                select 'RETURN_PRODUCT_SALE' table_name from dual union all
                select 'SUPPLIERS' table_name from dual
   )
   loop
   dbms_output.put_line('....Drop table '||i.table_name);
   begin
       select 'Y' into v_table_exists
       from USER_TABLES
       where TABLE_NAME=i.table_name;

       v_sql := 'drop table '||i.table_name;
       execute immediate v_sql;
       dbms_output.put_line('........Table '||i.table_name||' dropped successfully');
       
   exception
       when no_data_found then
           dbms_output.put_line('........Table already dropped');
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
/

----------------------------------------------------------------------------------------
-------------------------------CREATING TABLE NOW---------------------------------------
----------------------------------------------------------------------------------------
CREATE TABLE CUSTOMER (CUSTOMER_ID NUMBER(8) NOT NULL PRIMARY KEY,
                        CUS_F_NAME VARCHAR2(20) NOT NULL,
                        CUS_L_NAME VARCHAR2(20),
                        CUS_DOB	 DATE NOT NULL,
                        CUS_SINCE DATE NOT NULL,
                        CUS_GENDER	VARCHAR2(6) NOT NULL,
                        CUS_CONTACT_NO	NUMBER(10) NOT NULL,
                        CUS_ALTERNATE_NO NUMBER(10),
                        CUS_EMAIL_ID	VARCHAR2(50) NOT NULL,
                        CUS_ADDRESS_1	VARCHAR2(50) NOT NULL,
                        CUS_ADDRESS_2	VARCHAR2(50),
                        CUS_CITY	VARCHAR2(20) NOT NULL,
                        CUS_STATE	VARCHAR2(20) NOT NULL,
                        CUS_COUNTRY	 VARCHAR2(20) NOT NULL,
                        CUS_ZIP	NUMBER(5) NOT NULL
                        );

CREATE TABLE ADMIN (ADMIN_ID NUMBER(5) NOT NULL PRIMARY KEY,
                    ADMIN_F_NAME VARCHAR2(20) NOT NULL,
                    ADMIN_L_NAME VARCHAR2(20) NOT NULL,
                    ADMIN_DOB DATE NOT NULL,
                    ADMIN_SINCE	DATE NOT NULL,
                    ADMIN_EMAIL_ID	VARCHAR2(50) NOT NULL,
                    ADMIN_CONTACT_NO NUMBER(10) NOT NULL
                    );
CREATE TABLE SUPPLIERS (SUPPLIER_ID	NUMBER(5) NOT NULL PRIMARY KEY,
                        SUPPLIER_NAME	VARCHAR2(20) NOT NULL,
                        SUPPLIER_CONTACT_NO	NUMBER(10) NOT NULL,
                        SUPPLIER_EMAIL_ID	VARCHAR2(50) NOT NULL,
                        SUPPLIER_ADDRESS_1	VARCHAR2(50) NOT NULL,
                        SUPPLIER_ADDRESS_2	VARCHAR2(50),
                        SUPPLIER_CITY	VARCHAR2(20) NOT NULL,
                        SUPPLIER_STATE	VARCHAR2(20) NOT NULL,
                        SUPPLIER_ZIP	NUMBER(5) NOT NULL,
                        SUPPLIER_SINCE	DATE
                        );
CREATE TABLE STOCK (STOCK_ID NUMBER(9) NOT NULL PRIMARY KEY,
                    STOCK_NAME	VarChar2(20) NOT NULL,
                    STOCK_QUANTITY NUMBER(5) NOT NULL,
                    REORDER_LEVEL NUMBER(5) NOT NULL,
                    STOCK_PRICE	FLOAT(5) NOT NULL,
                    SPECS	VarChar2(1000) NOT NULL,
                    STOCK_SUPPLIER_ID NUMBER(5) NOT NULL,
                    STOCK_IN_DATE	Date,
                    MANUFACTURER_NAME	VarChar2(20)
                    );
                    
CREATE TABLE CUSTOMER_TRANSACTION ( ORDER_NUMBER	NUMBER(10) NOT NULL PRIMARY KEY,
                                    ORDER_CUS_ID	NUMBER(8) NOT NULL,
                                    ORDER_DATE	DATE NOT NULL,	
                                    ORDER_PAYMENT_METHOD	VARCHAR2(6) NOT NULL
                                    );

CREATE TABLE SUPPLIER_TRANSACTION(  SUPPLIER_TRANSACTION_ID	NUMBER(10) NOT NULL PRIMARY KEY,
                                    SUPPLIER_STOCK_ID	NUMBER	(9) NOT NULL,
                                    ADMIN_ID	NUMBER(5) NOT NULL,
                                    SUPPLIER_TRANSACTION_DATE DATE NOT NULL,
                                    SUPPLY_QTY	NUMBER(5) NOT NULL,
                                    SUPPLY_PRICE FLOAT(8) NOT NULL
                                    );

CREATE TABLE RETURN_TRANSACTION (   RETURN_NUMBER	NUMBER (10) NOT NULL PRIMARY KEY,
                                    RETURN_CUSTOMER_ID NUMBER(8) NOT NULL,
                                    RETURN_DATE	DATE NOT NULL
                                    );

CREATE TABLE PRODUCT_SALE ( SALE_ID	NUMBER(10) NOT NULL PRIMARY KEY,
                            ORDER_NUMBER NUMBER(10) NOT NULL,
                            SALE_STOCK_ID NUMBER(12) NOT NULL,
                            ORDER_QTY NUMBER(5) NOT NULL
                            );
CREATE TABLE RETURN_PRODUCT_SALE ( PRODUCT_RETURN_ID NUMBER(10) NOT NULL PRIMARY KEY,
                                    RETURN_NUMBER NUMBER(10) NOT NULL,
                                    RETURN_STOCK_ID NUMBER(9) NOT NULL,
                                    RETURN_QTY NUMBER(5) NOT NULL
                                    );
