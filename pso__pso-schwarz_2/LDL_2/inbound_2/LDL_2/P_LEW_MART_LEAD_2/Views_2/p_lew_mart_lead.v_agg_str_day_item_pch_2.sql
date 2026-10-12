create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_AGG_STR_DAY_ITEM_PCH_2(
	CLIENT_ID,
	LOC_SID_STORE,
	ITEM_SID,
	PCWO_REASON_ID,
	SFOTYPE_ID,
	CURRENCY_ISO_CD,
	PCH_BNL_SWITCH_FG,
	DWH_CAL_DT,
	VAL_PRICE_CHANGE,
	DWH_UPDATED
) as
WITH cte_union AS (
SELECT 
  client_id
, loc_sid_store
, item_sid
, pcwo_reason_id
, sfotype_id
, pch_bnl_switch_fg
, dwh_cal_dt
, val_price_change
, dwh_updated
FROM p_lew_mart_lead.t_agg_str_day_item_pch_2
UNION ALL
SELECT 
  client_id
, loc_sid AS loc_sid_store
, item_sid
, 41 AS pcwo_reason_id
, 134 AS sfotype_id
, 1 AS pch_bnl_switch_fg
, dwh_cal_dt
, discount_val_net*-1 AS val_price_change
, dwh_updated
FROM P_LEW_MART_LEAD.T_AGG_STR_DAY_ITM_PCH_LDLPL_LOYALTY_2
WHERE pcwo_reason_id = 41 
UNION ALL
SELECT 
  client_id
, loc_sid AS loc_sid_store
, item_sid
, CASE WHEN  pcwo_reason_id = 41 THEN 46 
	   ELSE pcwo_reason_id 
	   END AS pcwo_reason_id
, 134 AS sfotype_id
, 1 AS pch_bnl_switch_fg
, dwh_cal_dt
, discount_val_net AS val_price_change
, dwh_updated
FROM P_LEW_MART_LEAD.T_AGG_STR_DAY_ITM_PCH_LDLPL_LOYALTY_2
)
SELECT
  v.client_id
, v.loc_sid_store
, itmp.item_sid_map    AS item_sid
, v.pcwo_reason_id
, v.sfotype_id
, cry.currency_iso_cd
, v.pch_bnl_switch_fg
, v.dwh_cal_dt
, v.val_price_change / CASE WHEN cry.rate_currency_exchange = 0 THEN NULL ELSE cry.rate_currency_exchange END  AS val_price_change
, dwh_updated
FROM cte_union AS v
 INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry
    ON v.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end

 INNER JOIN p_lew_core_ac.v_item_map_key_2 itmp
    ON itmp.client_id = v.client_id
   AND itmp.item_sid  = v.item_sid

LEFT OUTER JOIN p_lew_bil_ac.v_org_store_merge_2 AS osm
ON  v.client_id     = osm.client_id
AND v.loc_sid_store = osm.loc_sid_store
AND osm.aspect_id     = 1   
;
