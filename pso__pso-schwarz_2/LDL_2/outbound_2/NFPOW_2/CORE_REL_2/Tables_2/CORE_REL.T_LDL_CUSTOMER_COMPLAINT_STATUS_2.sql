/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_status_2
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_customer_complaint_status_2 (
ldl_cust_complaint_status_cd STRING(100) NOT NULL
OPTIONS(description='Status_2 code that uniquely identifies the customer case status_2 (assigned by DWH).            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_STATUS.CUST_COMPLAINT_STATUS_CD'),
ldl_cust_complaint_status_descr STRING(250)
OPTIONS(description='Status_2 description.            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_STATUS.CUST_COMPLAINT_STATUS_DESCR'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_cust_complaint_status_cd) NOT ENFORCED
)
OPTIONS(description='Customer case status_2 assigned to case (Waiting for Review, In Progress, Reopened, etc.).             LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_STATUS_2');