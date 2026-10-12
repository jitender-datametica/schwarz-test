/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_case_2
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_customer_complaint_case_2 (
ldl_cust_complaint_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for customer compaint case.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE.CUST_COMPLAINT_SID'),
src_cust_complaint_nr STRING(250) NOT NULL
OPTIONS(description='The unique key generated in Salesforce if a case is added to the SF database.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE.SRC_CUST_COMPLAINT_NR'),
ldl_cust_complaint_nr BIGNUMERIC(38,0)
OPTIONS(description='Customer compaint case number as shown to user.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE.CUST_COMPLAINT_NR'),
case_open_dt DATE
OPTIONS(description='The first time an agent accepts the case and starts working on it, in UTC time.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE.CASE_OPEN_DT'),
src_name STRING(100)
OPTIONS(description='Source System Name (Salesforce or BSI).            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE.SRC_NAME'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_cust_complaint_sid) NOT ENFORCED
)
OPTIONS(description='The table contais customer complaint cases opened in Salesforce or BSI systems as a result of customer reporting issues via mail, web-form or phone.             LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_2');