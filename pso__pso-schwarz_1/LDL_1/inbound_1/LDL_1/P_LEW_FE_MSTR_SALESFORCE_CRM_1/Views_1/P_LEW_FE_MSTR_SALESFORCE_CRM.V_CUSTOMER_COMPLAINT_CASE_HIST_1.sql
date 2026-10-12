CREATE OR REPLACE VIEW P_LEW_FE_MSTR_SALESFORCE_CRM.V_CUSTOMER_COMPLAINT_CASE_HIST_1(
	CLIENT_ID
	,CUST_COMPLAINT_SID
	,SRC_CLIENT_ID
	,ITEM_SID
	,SRC_ORIG_ITEM_NR
	,SRC_ITEM_NR
	,SRC_ITEM_NAME
	,SRC_ITEM_DESCR
	,SRC_ITEM_LONG_DESCR
	,SRC_ITEM_IAN
	,SRC_ITEM_GTIN
	,SRC_ITEM_GTIN_DESCR
	,SRC_ITEM_SAP_NR
	,ITEM_GRP_SID
	,SRC_ITEM_GROUP_NR
	,SRC_ITEM_GROUP_NAME
	,ITEM_FAM_GRP_SID
	,SRC_ITEM_FAMILY_NR
	,SRC_ITEM_FAMILY_NAME
	,CUST_COMPLAINT_SRV_CENTER_CD
	,CUST_COMPLAINT_SRV_AREA_CD
	,ORIG_CUST_COMPLAINT_SRV_AREA_CD
	,CUST_COMPLAINT_CONTACT_TYPE_CD
	,CUST_COMPLAINT_STATUS_CD
	,CUST_COMPLAINT_SALES_CHANNEL_CD
	,CUST_COMPLAINT_ORIGIN_CD
	,CUST_COMPLAINT_ORIGIN_GROUP_NAME
	,BRAND_SID
	,SRC_BRAND_NAME
	,SUP_SID
	,SRC_SUP_NR
	,SRC_SUP_NAME
	,STORE_LOC_SID
	,SRC_STORE_NAME
	,WH_LOC_SID
	,SRC_WH_NAME
	,SRC_WH_ACCT_NAME
	,SRC_WH_DESCR
	,CUST_COMPLAINT_CAT_SID
	,CUST_COMPLAINT_CAT_NR
	,CUST_COMPLAINT_LOW_LVL_CAT_NAME
	,CUST_COMPLAINT_REASON
	,CUST_COMPLAINT_SHORT_DESCR
	,CUST_COMPLAINT_DESCR
	,LOT_NR
	,PURCHASE_DT
	,BEST_BEFORE_DT
	,CASE_CLOSE_DT
	,IS_CRITICAL_FG
	,IS_ILLNESS_INJURY_FG
	,IS_MAIN_CASE_FG
	,IS_SUB_CASE_FG
	,IS_PARENT_CASE_FG
	,IS_CHILD_CASE_FG
	,DWH_VALID_FROM
	,DELETED_FG
	,DWH_VALID_TO
	,DWH_LOAD_ID
	,DWH_CREATED
	,DWH_UPDATED
) AS 
       SELECT
	k1.client_id
	,k1.cust_complaint_sid
	,k1.src_client_id
	,k1.item_sid
	,l1.SRC_ORIG_ITEM_NR
	,k1.src_item_nr
	,k1.src_item_name
	,k1.src_item_descr
	,k1.src_item_long_descr
	,k1.src_item_ian
	,k1.src_item_gtin  
	,k1.src_item_gtin_descr  
	,k1.src_item_sap_nr  
	,k1.item_grp_sid  
	,k1.src_item_group_nr 
	,k1.src_item_group_name  
	,k1.item_fam_grp_sid  
	,k1.src_item_family_nr 
	,k1.src_item_family_name 
	,k1.cust_complaint_srv_center_cd  
	,k1.cust_complaint_srv_area_cd  
	,k1.orig_cust_complaint_srv_area_cd  
	,k1.cust_complaint_contact_type_cd 
	,k1.cust_complaint_status_cd  
	,k1.cust_complaint_sales_channel_cd  
	,k1.cust_complaint_origin_cd  
	,k1.cust_complaint_origin_group_name  
	,k1.brand_sid  
	,k1.src_brand_name  
	,k1.sup_sid  
	,k1.src_sup_nr  
	,k1.src_sup_name  
	,k1.store_loc_sid 
	,k1.src_store_name  
	,k1.wh_loc_sid  
	,k1.src_wh_name  
	,k1.src_wh_acct_name  
	,k1.src_wh_descr  
	,k1.cust_complaint_cat_sid  
	,k1.cust_complaint_cat_nr  
	,k1.cust_complaint_low_lvl_cat_name  
	,k1.cust_complaint_reason  
	,k1.cust_complaint_short_descr  
	,k1.cust_complaint_descr  
	,k1.lot_nr 
	,k1.purchase_dt 
	,k1.best_before_dt 
	,k1.case_close_dt 
	,k1.is_critical_fg  
	,k1.is_illness_injury_fg 
	,k1.is_main_case_fg  
	,k1.is_sub_case_fg  
	,k1.is_parent_case_fg  
	,k1.is_child_case_fg  
	,k1.dwh_valid_from 
	,k1.deleted_fg 
	,k1.dwh_valid_to  
	,k1.dwh_load_id 
	,k1.dwh_created 
	,k1.dwh_updated
FROM P_LEW_CORE_AC.V_CUSTOMER_COMPLAINT_CASE_HIST_1 k1
LEFT OUTER JOIN P_LEW_CORE_AC.V_ITEM_1 l1
ON (k1.ITEM_SID=l1.ITEM_SID)      
       WHERE k1.CUST_COMPLAINT_SID IN 
        (SELECT A1.CUST_COMPLAINT_SID
            FROM P_LEW_CORE_AC.V_CUSTOMER_COMPLAINT_CASE_HIST_1 A1
                JOIN P_LEW_CORE_AC.V_customer_complaint_case_1 B1
                ON A1.CUST_COMPLAINT_SID=B1.CUST_COMPLAINT_SID
                WHERE CURRENT_DATE() BETWEEN A1.dwh_valid_from AND A1.dwh_valid_to
                AND case_open_dt>='2020-05-08'
                AND B1.SRC_NAME='BSI'
                AND A1.IS_CRITICAL_FG=1
                AND A1.CUST_COMPLAINT_CAT_NR LIKE ANY ('2.%','3.%','4.%','9.%','10.%')                  
        UNION
        SELECT A1.CUST_COMPLAINT_SID
            FROM P_LEW_CORE_AC.V_CUSTOMER_COMPLAINT_CASE_HIST_1 A1
                JOIN P_LEW_CORE_AC.V_customer_complaint_case_1 B1
                ON A1.CUST_COMPLAINT_SID=B1.CUST_COMPLAINT_SID
                WHERE CURRENT_DATE() BETWEEN A1.dwh_valid_from AND A1.dwh_valid_to
                AND case_open_dt>='2020-05-08'
                AND B1.SRC_NAME='Salesforce'
                AND A1.IS_CRITICAL_FG=1
                AND A1.IS_MAIN_CASE_FG=1
                AND A1.CUST_COMPLAINT_CAT_NR LIKE ANY ('2.%','3.%'));