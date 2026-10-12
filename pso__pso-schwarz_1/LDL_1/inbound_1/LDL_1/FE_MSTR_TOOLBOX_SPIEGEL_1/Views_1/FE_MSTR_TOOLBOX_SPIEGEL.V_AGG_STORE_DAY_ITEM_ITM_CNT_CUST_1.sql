create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORE_DAY_ITEM_ITM_CNT_CUST_1(
	CLIENT_ID,
	LOC_SID_STORE,
	SRC_ORIG_STORE_NR,
	MOVE_TO_STORE_ID,
	DWH_CAL_DT,
	CY_MONTH,
	ITEM_SID,
	SRC_ORIG_ITEM_NR,
	ITEM_GRP_INT_SID,
	ITEMGROUP_INT_ID,
	SUB_ITEM_GRP_SID,
	SUBITEMGROUP_ID,
	ITEM_FAM_GRP_SID,
	ITEM_FAMILYGROUP_ID,
	ITM_CNT_CUSTOMER,
	WGI_CNT_CUSTOMER,
	UWG_CNT_CUSTOMER,
	FAM_CNT_CUSTOMER,
	STORE_DAY_CNT_CUSTOMER
) as

SELECT
  s.client_id
, s.loc_sid_store
, o.orig_store_nr AS src_orig_store_nr
, o.move_to_store_id
, s.dwh_cal_dt
, s.cy_month
, s.item_sid
, s.src_orig_item_nr
, s.item_grp_int_sid
, s.itemgroup_int_id
, s.sub_item_grp_sid
, s.subitemgroup_id
, s.item_fam_grp_sid
, s.item_familygroup_id
, s.itm_cnt_customer
, s.WGI_CNT_CUSTOMER
, s.UWG_CNT_CUSTOMER
, s.FAM_CNT_CUSTOMER
, s.STORE_DAY_CNT_CUSTOMER
FROM P_LEW_MART_LEAD.T_AGG_STORE_DAY_ITEM_CUST_CNT_1 AS s
INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.V_ORG_STORE_MERGE_BGES_1 AS o
ON s.client_id = o.client_id
AND s.loc_sid_store = o.store_id
WHERE s.dwh_cal_dt >= DATEADD(days, -400, CURRENT_DATE());
