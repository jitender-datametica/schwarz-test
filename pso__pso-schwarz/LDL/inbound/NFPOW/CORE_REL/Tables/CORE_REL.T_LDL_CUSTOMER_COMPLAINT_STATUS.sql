/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_status
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_CUSTOMER_COMPLAINT_STATUS DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_cust_complaint_status_cd        VARCHAR(100)     NOT NULL COMMENT 'Status code that uniquely identifies the customer case status (assigned by DWH).
            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_STATUS.CUST_COMPLAINT_STATUS_CD',
   ldl_cust_complaint_status_descr     VARCHAR(250)     COMMENT 'Status description.
            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_STATUS.CUST_COMPLAINT_STATUS_DESCR',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CUSTOMER_COMPLAINT_STATUS PRIMARY KEY (ldl_cust_complaint_status_cd) NOT ENFORCED 
)  COMMENT = 'Customer case status assigned to case (Waiting for Review, In Progress, Reopened, etc.).
             LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_STATUS';

