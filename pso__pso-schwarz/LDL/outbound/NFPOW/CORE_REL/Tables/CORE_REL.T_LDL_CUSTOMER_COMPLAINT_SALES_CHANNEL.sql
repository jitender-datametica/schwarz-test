/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_sales_channel
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_customer_complaint_sales_channel (
ldl_cust_complaint_sales_channel_cd STRING(100) NOT NULL
OPTIONS(description='A code for the customer complaint sales channel.            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_SALES_CHANNEL.CUST_COMPLAINT_SALES_CHANNEL_CD'),
ldl_cust_complaint_sales_channel_descr STRING(250)
OPTIONS(description='Customer sales channel description (Lidl Shop, Online Shop).            LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_SALES_CHANNEL.CUST_COMPLAINT_SALES_CHANNEL_DESCR'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_cust_complaint_sales_channel_cd) NOT ENFORCED
)
OPTIONS(description='Indicates the sales channel through which the purchase was done for which the complaint case was filed.             LDL: P_LEW_CORE.T_REF_CUSTOMER_COMPLAINT_SALES_CHANNEL');