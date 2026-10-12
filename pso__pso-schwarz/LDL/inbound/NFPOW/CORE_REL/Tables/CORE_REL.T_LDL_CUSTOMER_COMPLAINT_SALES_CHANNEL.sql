/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_sales_channel
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_CUSTOMER_COMPLAINT_SALES_CHANNEL DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_cust_complaint_sales_channel_cd VARCHAR(100)     NOT NULL COMMENT 'A code for the customer complaint sales channel.
            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_SALES_CHANNEL.CUST_COMPLAINT_SALES_CHANNEL_CD',
   ldl_cust_complaint_sales_channel_descr VARCHAR(250)     COMMENT 'Customer sales channel description (Lidl Shop, Online Shop).
            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_SALES_CHANNEL.CUST_COMPLAINT_SALES_CHANNEL_DESCR',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CUSTOMER_COMPLAINT_SALES_CHANNEL PRIMARY KEY (ldl_cust_complaint_sales_channel_cd) NOT ENFORCED 
)  COMMENT = 'Indicates the sales channel through which the purchase was done for which the complaint case was filed.
             LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_SALES_CHANNEL';

