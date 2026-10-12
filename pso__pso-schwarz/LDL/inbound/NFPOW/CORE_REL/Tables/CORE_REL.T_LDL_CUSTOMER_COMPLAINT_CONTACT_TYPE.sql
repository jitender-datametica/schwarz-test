/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_contact_type
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_CUSTOMER_COMPLAINT_CONTACT_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_cust_complaint_contact_type_cd  VARCHAR(100)     NOT NULL COMMENT 'Customer complaint contact type code.
            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_CONTACT_TYPE.CUST_COMPLAINT_CONTACT_TYPE_CD',
   ldl_cust_complaint_contact_type_descr VARCHAR(250)     COMMENT 'Customer complaint contact type description (Praise, Request, Criticism).
            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_CONTACT_TYPE.CUST_COMPLAINT_CONTACT_TYPE_DESCR',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CUSTOMER_COMPLAINT_CONTACT_TYPE PRIMARY KEY (ldl_cust_complaint_contact_type_cd) NOT ENFORCED 
)  COMMENT = 'Indicates the mood of the customer in combination with the case (Praise, Request, Criticism).
             LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_CONTACT_TYPE';

