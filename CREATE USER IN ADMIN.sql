--------------1ST STEP---------------------
---- CREATE THIS USER FROM ORACLE-ADMIN-----------------------------------------
----THIS USER WILL CREATE TABLES AND INSERT DATA AND CREATE OTHER USERS---------

-------------------CREATE USER-------------------------

create user SUPER_ADMIN identified by Parkerhill#13;

------------------GRANT PERMISSION---------------------
grant connect to SUPER_ADMIN;
GRANT RESOURCE TO SUPER_ADMIN;
alter user SUPER_ADMIN quota 20M on data;
grant create user to super_admin;
grant alter user to super_admin;
grant create view to super_admin;



BEGIN
    FOR T IN (SELECT TABLE_NAME FROM ALL_TABLES WHERE OWNER='SUPER_ADMIN')LOOP 
    EXECUTE IMMEDIATE 'GRANT ALL PRIVILEGES ON SUPER_ADMIN.'||T.TABLE_NAME||' TO SUPER_ADMIN';
    END LOOP;
END;