/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_case
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_CUSTOMER_COMPLAINT_CASE DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_cust_complaint_sid              NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for customer compaint case.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE.CUST_COMPLAINT_SID',
   src_cust_complaint_nr               VARCHAR(250)     NOT NULL COMMENT 'The unique key generated in Salesforce if a case is added to the SF database.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE.SRC_CUST_COMPLAINT_NR',
   ldl_cust_complaint_nr               NUMBER(38,0)     COMMENT 'Customer compaint case number as shown to user.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE.CUST_COMPLAINT_NR',
   case_open_dt                        DATE             COMMENT 'The first time an agent accepts the case and starts working on it, in UTC time.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE.CASE_OPEN_DT',
   src_name                            VARCHAR(100)     COMMENT 'Source System Name (Salesforce or BSI).
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE.SRC_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CUSTOMER_COMPLAINT_CASE PRIMARY KEY (ldl_cust_complaint_sid) NOT ENFORCED 
)  COMMENT = 'The table contais customer complaint cases opened in Salesforce or BSI systems as a result of customer reporting issues via mail, web-form or phone.
             LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE';

