/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_origin_2
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_customer_complaint_origin_2 (
ldl_cust_complaint_origin_cd STRING(100) NOT NULL
OPTIONS(description='Customer complaint origin code (Webform, etc.).            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_ORIGIN.CUST_COMPLAINT_ORIGIN_CD'),
ldl_cust_complaint_origin_descr STRING(250)
OPTIONS(description='Customer complaint origin description.            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_ORIGIN.CUST_COMPLAINT_ORIGIN_DESCR'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_cust_complaint_origin_cd) NOT ENFORCED
)
OPTIONS(description='Indicates how the customer complaint case was submited.             LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_ORIGIN_2');