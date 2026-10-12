create or replace view LDL_PRODUCTION.P_LEW_MART_CS.V_BW_WRITEOFF_CUM_BY_1(
	CLIENT_ID,
	WH_ID,
	CY_MONTH,
	ASPECT_ID,
	ITEM_FAMILYGROUP_ID,
	SUBITEMGROUP_ID,
	SUBITEMGROUP_ID0,
	BUYING_LIST_TYPE_ID,
	CURR_TOT_ID,
	CURRENCY_ISO_CD,
	VAL_WRITEOFF_CUM_BY
) as
SELECT	
    client_id
  , wh_id    
  , cy_month
  , aspect_id
  , item_familygroup_id
  , subitemgroup_id
  , subitemgroup_id0
  , buying_list_type_id
  , curr_tot_id
  , currency_iso_cd
  , val_writeoff_cum_by
FROM	p_lew_mart_cs.t_bw_writeoff_cum_by_1   
;
