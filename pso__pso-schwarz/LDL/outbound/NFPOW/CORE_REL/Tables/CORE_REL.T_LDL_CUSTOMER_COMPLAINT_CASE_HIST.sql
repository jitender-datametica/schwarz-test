/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_case_hist
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_customer_complaint_case_hist (
ldl_cust_complaint_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for customer compaint case.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_SID'),
src_client_id STRING(250)
OPTIONS(description='Client ID derived from the data in source system, might be null.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_CLIENT_ID'),
ldl_item_sid BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key ITEM (eindeutig ueber alle Laender / Mandanten hinweg).            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.ITEM_SID'),
src_item_nr STRING(250)
OPTIONS(description='Technical identifier from source system for a product causing a compaint case.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_NR'),
src_item_name STRING(250)
OPTIONS(description='Product name as saved in a compaint case. Comes from WaWi or LDI.             LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_NAME'),
src_item_descr STRING(250)
OPTIONS(description='Product description as saved in a compaint case. Comes from WaWi or LDI.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_DESCR'),
src_item_long_descr STRING(250)
OPTIONS(description='Long formatted product description. This data only comes from WaWi.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_LONG_DESCR'),
src_item_ian_nr STRING(250)
OPTIONS(description='Product IAN as saved in a compaint case.             Comes from WaWi or LDI. If there is not any wrong data it should have a length of 5, 6 or 7 characters.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_IAN'),
src_item_gtin_nr STRING(250)
OPTIONS(description='Product EAN / GTIN as saved in a compaint case. Comes from WaWi or LDI.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_GTIN'),
src_item_gtin_descr STRING(250)
OPTIONS(description='Product description EAN / GTIN as saved in a compaint case.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_GTIN_DESCR'),
src_item_sap_nr STRING(250)
OPTIONS(description='Stores the online shop SAP article number from source system. This data only comes from LDI.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_SAP_NR'),
src_item_grp_nr STRING(250)
OPTIONS(description='Merchandise subgroup number as coming from Salesforce. Data only comes from WaWi. 999 is a ficticious value used when the data comes from LDI.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_GROUP_NR'),
src_item_grp_name STRING(100)
OPTIONS(description='Merchandise subgroup picklist as coming from Salesforce. Data only comes from WaWi. 999 is a ficticious value used when the data comes from LDI.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_GROUP_NAME'),
src_item_fam_nr STRING(250)
OPTIONS(description='Merchandise family number as coming from Salesforce. This data only comes from WaWi.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_FAMILY_NR'),
src_item_fam_name STRING(100)
OPTIONS(description='Merchandise family number name as coming from Salesforce. This data only comes from WaWi.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_FAMILY_NAME'),
ldl_cust_complaint_srv_center_cd STRING(100)
OPTIONS(description='The code for the service center for proceeding customer complaint cases.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_SRV_CENTER_CD'),
ldl_cust_complaint_srv_area_cd STRING(100)
OPTIONS(description='The code for the service area serving customer complaint cases.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_SRV_AREA_CD'),
ldl_orig_cust_complaint_srv_area_cd STRING(100)
OPTIONS(description='The code for the service area originating customer complaint cases.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.ORIG_CUST_COMPLAINT_SRV_AREA_CD'),
ldl_cust_complaint_contact_type_cd STRING(100)
OPTIONS(description='A code for customer complaint type.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_CONTACT_TYPE_CD'),
ldl_cust_complaint_status_cd STRING(100)
OPTIONS(description='Status code that uniquely identifies the customer case status (assigned by DWH).            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_STATUS_CD'),
ldl_cust_complaint_sales_channel_cd STRING(100)
OPTIONS(description='A code for the customer complaint sales channel.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_SALES_CHANNEL_CD'),
ldl_cust_complaint_origin_cd STRING(100)
OPTIONS(description='A code for the customer complaint origin (Webform, etc.).            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_ORIGIN_CD'),
ldl_cust_complaint_origin_grp_name STRING(100)
OPTIONS(description='A grouping for the customer complaint origin (Webform, etc.).            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_ORIGIN_GROUP_NAME'),
src_brand_name STRING(100)
OPTIONS(description='Product brand name from source system.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_BRAND_NAME'),
src_sup_nr STRING(100)
OPTIONS(description='Source Supplier Number.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_SUP_NR'),
src_sup_name STRING(100)
OPTIONS(description='Source Supplier Name.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_SUP_NAME'),
ldl_store_loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key LOCATION (eindeutig ueber alle Laender / Mandanten hinweg) for a store.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.STORE_LOC_SID'),
src_store_name STRING(100)
OPTIONS(description='Related store-account name.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_STORE_NAME'),
ldl_wh_loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key LOCATION (eindeutig ueber alle Laender / Mandanten hinweg) for a warehouse.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.WH_LOC_SID'),
src_wh_name STRING(100)
OPTIONS(description='Related warehouse name.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_WH_NAME'),
src_wh_acct_name STRING(100)
OPTIONS(description='Related accounting warehouse name.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_WH_ACCT_NAME'),
src_wh_descr STRING(250)
OPTIONS(description='Related warehouse description.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_WH_DESCR'),
ldl_cust_complaint_cat_sid BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key for category.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_CAT_SID'),
ldl_cust_complaint_cat_nr STRING(250)
OPTIONS(description='Category Number.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_CAT_NR'),
ldl_cust_complaint_low_lvl_cat_name STRING(100)
OPTIONS(description='Customer Category Lowest Level Name.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_LOW_LVL_CAT_NAME'),
ldl_cust_complaint_reason_txt STRING(1000)
OPTIONS(description='Reason for complaints QA.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_REASON'),
src_lot_nr STRING(100)
OPTIONS(description='Lot / batch number of a product.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.LOT_NR'),
purchase_dt DATE
OPTIONS(description='Date of purchase of a product.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.PURCHASE_DT'),
best_before_dt DATE
OPTIONS(description='Best before date of a product.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.BEST_BEFORE_DT'),
case_closed_dt DATE
OPTIONS(description='Closing date of the case.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CASE_CLOSE_DT'),
is_critical_fg BOOL
OPTIONS(description='Flag: Case is critical.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_CRITICAL_FG'),
is_illness_injury_fg BOOL
OPTIONS(description='Flag: Illness / injury occured.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_ILLNESS_INJURY_FG'),
is_main_case_fg BOOL
OPTIONS(description='Flag: Indicates if a case is a main case (vs. sub case).            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_MAIN_CASE_FG'),
is_sub_case_fg BOOL
OPTIONS(description='Flag: Indicates if a case is a sub case (vs. main case).            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_SUB_CASE_FG'),
is_parent_case_fg BOOL
OPTIONS(description='Flag: Indicates if a case is a parent case (vs. child case).            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_PARENT_CASE_FG'),
is_child_case_fg BOOL
OPTIONS(description='Flag: Indicates if a case is a child case (vs. parent case).            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_CHILD_CASE_FG'),
is_merge_case_fg BOOL
OPTIONS(description='Flag: Indicates if a case is a merged case.            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_MERGE_CASE_FG'),
dwh_deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.            LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.DELETED_FG'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Beginning of the validity interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).            LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.DWH_VALID_FROM'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).            LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.DWH_VALID_TO'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_cust_complaint_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The table contains customer complanit cases opened in Salesforce or BSI system as a result of customer reporting issues via mail, web-form or phone (historized version).             LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST');