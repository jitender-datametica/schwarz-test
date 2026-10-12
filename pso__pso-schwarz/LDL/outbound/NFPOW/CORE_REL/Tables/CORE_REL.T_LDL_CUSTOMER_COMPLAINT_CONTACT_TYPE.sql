/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_contact_type
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_customer_complaint_contact_type (
ldl_cust_complaint_contact_type_cd STRING(100) NOT NULL
OPTIONS(description='Customer complaint contact type code.            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_CONTACT_TYPE.CUST_COMPLAINT_CONTACT_TYPE_CD'),
ldl_cust_complaint_contact_type_descr STRING(250)
OPTIONS(description='Customer complaint contact type description (Praise, Request, Criticism).            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_CONTACT_TYPE.CUST_COMPLAINT_CONTACT_TYPE_DESCR'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_cust_complaint_contact_type_cd) NOT ENFORCED
)
OPTIONS(description='Indicates the mood of the customer in combination with the case (Praise, Request, Criticism).             LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_CONTACT_TYPE');