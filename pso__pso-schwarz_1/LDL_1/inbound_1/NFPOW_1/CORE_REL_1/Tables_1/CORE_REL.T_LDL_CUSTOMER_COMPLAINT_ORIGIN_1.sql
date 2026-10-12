/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_origin_1
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_CUSTOMER_COMPLAINT_ORIGIN_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_cust_complaint_origin_cd        VARCHAR(100)     NOT NULL COMMENT 'Customer complaint origin code (Webform, etc.).
            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_ORIGIN.CUST_COMPLAINT_ORIGIN_CD',
   ldl_cust_complaint_origin_descr     VARCHAR(250)     COMMENT 'Customer complaint origin description.
            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_ORIGIN.CUST_COMPLAINT_ORIGIN_DESCR',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CUSTOMER_COMPLAINT_ORIGIN PRIMARY KEY (ldl_cust_complaint_origin_cd) NOT ENFORCED 
)  COMMENT = 'Indicates how the customer complaint case was submited.
             LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_ORIGIN_1';

