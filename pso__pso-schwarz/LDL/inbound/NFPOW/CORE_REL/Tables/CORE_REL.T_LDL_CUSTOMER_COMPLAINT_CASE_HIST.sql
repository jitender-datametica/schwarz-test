/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_customer_complaint_case_hist
   generated from Powerdesigner on Mittwoch, 2. Juli 2025 09:39:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_CUSTOMER_COMPLAINT_CASE_HIST DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_cust_complaint_sid              NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for customer compaint case.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_SID',
   src_client_id                       VARCHAR(250)     COMMENT 'Client ID derived from the data in source system, might be null.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_CLIENT_ID',
   ldl_item_sid                        NUMBER(38,0)     COMMENT 'Surrogate Key ITEM (eindeutig ueber alle Laender / Mandanten hinweg).
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.ITEM_SID',
   src_item_nr                         VARCHAR(250)     COMMENT 'Technical identifier from source system for a product causing a compaint case.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_NR',
   src_item_name                       VARCHAR(250)     COMMENT 'Product name as saved in a compaint case. Comes from WaWi or LDI. 
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_NAME',
   src_item_descr                      VARCHAR(250)     COMMENT 'Product description as saved in a compaint case. Comes from WaWi or LDI.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_DESCR',
   src_item_long_descr                 VARCHAR(250)     COMMENT 'Long formatted product description. This data only comes from WaWi.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_LONG_DESCR',
   src_item_ian_nr                     VARCHAR(250)     COMMENT 'Product IAN as saved in a compaint case. 
            Comes from WaWi or LDI. If there is not any wrong data it should have a length of 5, 6 or 7 characters.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_IAN',
   src_item_gtin_nr                    VARCHAR(250)     COMMENT 'Product EAN / GTIN as saved in a compaint case. Comes from WaWi or LDI.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_GTIN',
   src_item_gtin_descr                 VARCHAR(250)     COMMENT 'Product description EAN / GTIN as saved in a compaint case.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_GTIN_DESCR',
   src_item_sap_nr                     VARCHAR(250)     COMMENT 'Stores the online shop SAP article number from source system. This data only comes from LDI.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_SAP_NR',
   src_item_grp_nr                     VARCHAR(250)     COMMENT 'Merchandise subgroup number as coming from Salesforce. Data only comes from WaWi. 999 is a ficticious value used when the data comes from LDI.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_GROUP_NR',
   src_item_grp_name                   VARCHAR(100)     COMMENT 'Merchandise subgroup picklist as coming from Salesforce. Data only comes from WaWi. 999 is a ficticious value used when the data comes from LDI.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_GROUP_NAME',
   src_item_fam_nr                     VARCHAR(250)     COMMENT 'Merchandise family number as coming from Salesforce. This data only comes from WaWi.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_FAMILY_NR',
   src_item_fam_name                   VARCHAR(100)     COMMENT 'Merchandise family number name as coming from Salesforce. This data only comes from WaWi.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_ITEM_FAMILY_NAME',
   ldl_cust_complaint_srv_center_cd    VARCHAR(100)     COMMENT 'The code for the service center for proceeding customer complaint cases.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_SRV_CENTER_CD',
   ldl_cust_complaint_srv_area_cd      VARCHAR(100)     COMMENT 'The code for the service area serving customer complaint cases.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_SRV_AREA_CD',
   ldl_orig_cust_complaint_srv_area_cd VARCHAR(100)     COMMENT 'The code for the service area originating customer complaint cases.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.ORIG_CUST_COMPLAINT_SRV_AREA_CD',
   ldl_cust_complaint_contact_type_cd  VARCHAR(100)     COMMENT 'A code for customer complaint type.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_CONTACT_TYPE_CD',
   ldl_cust_complaint_status_cd        VARCHAR(100)     COMMENT 'Status code that uniquely identifies the customer case status (assigned by DWH).
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_STATUS_CD',
   ldl_cust_complaint_sales_channel_cd VARCHAR(100)     COMMENT 'A code for the customer complaint sales channel.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_SALES_CHANNEL_CD',
   ldl_cust_complaint_origin_cd        VARCHAR(100)     COMMENT 'A code for the customer complaint origin (Webform, etc.).
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_ORIGIN_CD',
   ldl_cust_complaint_origin_grp_name  VARCHAR(100)     COMMENT 'A grouping for the customer complaint origin (Webform, etc.).
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_ORIGIN_GROUP_NAME',
   src_brand_name                      VARCHAR(100)     COMMENT 'Product brand name from source system.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_BRAND_NAME',
   src_sup_nr                          VARCHAR(100)     COMMENT 'Source Supplier Number.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_SUP_NR',
   src_sup_name                        VARCHAR(100)     COMMENT 'Source Supplier Name.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_SUP_NAME',
   ldl_store_loc_sid                   NUMBER(38,0)     COMMENT 'Surrogate Key LOCATION (eindeutig ueber alle Laender / Mandanten hinweg) for a store.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.STORE_LOC_SID',
   src_store_name                      VARCHAR(100)     COMMENT 'Related store-account name.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_STORE_NAME',
   ldl_wh_loc_sid                      NUMBER(38,0)     COMMENT 'Surrogate Key LOCATION (eindeutig ueber alle Laender / Mandanten hinweg) for a warehouse.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.WH_LOC_SID',
   src_wh_name                         VARCHAR(100)     COMMENT 'Related warehouse name.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_WH_NAME',
   src_wh_acct_name                    VARCHAR(100)     COMMENT 'Related accounting warehouse name.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_WH_ACCT_NAME',
   src_wh_descr                        VARCHAR(250)     COMMENT 'Related warehouse description.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.SRC_WH_DESCR',
   ldl_cust_complaint_cat_sid          NUMBER(38,0)     COMMENT 'Surrogate Key for category.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_CAT_SID',
   ldl_cust_complaint_cat_nr           VARCHAR(250)     COMMENT 'Category Number.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_CAT_NR',
   ldl_cust_complaint_low_lvl_cat_name VARCHAR(100)     COMMENT 'Customer Category Lowest Level Name.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_LOW_LVL_CAT_NAME',
   ldl_cust_complaint_reason_txt       VARCHAR(1000)    COMMENT 'Reason for complaints QA.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CUST_COMPLAINT_REASON',
   src_lot_nr                          VARCHAR(100)     COMMENT 'Lot / batch number of a product.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.LOT_NR',
   purchase_dt                         DATE             COMMENT 'Date of purchase of a product.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.PURCHASE_DT',
   best_before_dt                      DATE             COMMENT 'Best before date of a product.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.BEST_BEFORE_DT',
   case_closed_dt                      DATE             COMMENT 'Closing date of the case.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.CASE_CLOSE_DT',
   is_critical_fg                      BOOLEAN          COMMENT 'Flag: Case is critical.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_CRITICAL_FG',
   is_illness_injury_fg                BOOLEAN          COMMENT 'Flag: Illness / injury occured.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_ILLNESS_INJURY_FG',
   is_main_case_fg                     BOOLEAN          COMMENT 'Flag: Indicates if a case is a main case (vs. sub case).
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_MAIN_CASE_FG',
   is_sub_case_fg                      BOOLEAN          COMMENT 'Flag: Indicates if a case is a sub case (vs. main case).
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_SUB_CASE_FG',
   is_parent_case_fg                   BOOLEAN          COMMENT 'Flag: Indicates if a case is a parent case (vs. child case).
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_PARENT_CASE_FG',
   is_child_case_fg                    BOOLEAN          COMMENT 'Flag: Indicates if a case is a child case (vs. parent case).
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_CHILD_CASE_FG',
   is_merge_case_fg                    BOOLEAN          COMMENT 'Flag: Indicates if a case is a merged case.
            LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST.IS_MERGE_CASE_FG',
   dwh_deleted_fg                      NUMBER(38,0)     NOT NULL COMMENT 'If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.
            LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.DELETED_FG',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Beginning of the validity interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.DWH_VALID_FROM',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.DWH_VALID_TO',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CUSTOMER_COMPLAINT_CASE_HIST PRIMARY KEY (ldl_cust_complaint_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'The table contains customer complanit cases opened in Salesforce or BSI system as a result of customer reporting issues via mail, web-form or phone (historized version).
             LDL: P_LEW_CORE.T_CUSTOMER_COMPLAINT_CASE_HIST';

