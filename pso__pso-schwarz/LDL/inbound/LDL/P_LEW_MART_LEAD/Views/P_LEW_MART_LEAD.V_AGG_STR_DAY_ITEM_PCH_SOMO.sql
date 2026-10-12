/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for V_AGG_STR_DAY_ITEM_PCH_SOMO.
#----------------------------------------------------------------------------
# History:
#  1.0  13.04.2023    Bialek, Aleksander           Initial, ADO WI: 464213, Intrduction of separate PV view dedicated for SOMO context analysis. 
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STR_DAY_ITEM_PCH_SOMO (
	CLIENT_ID COMMENT 'The unique identifier for the Lidl country.',
	LOC_SID_STORE COMMENT 'surrogate Key for Store.',
	ITEM_SID COMMENT 'mapped Surrogate Key Item.',
	CONTAINER_ID ,
	CONTAINER_HIST_ID,	
	PCWO_REASON_ID COMMENT 'Unique ID for PV >100 local reasons.',
	SFOTYPE_ID COMMENT 'document type.',
	CURRENCY_ISO_CD COMMENT 'Currency .',
	PCH_BNL_SWITCH_FG COMMENT '1=calculated with new method.',
	DWH_CAL_DT COMMENT 'Logical Date of Row.',
	VAL_PRICE_CHANGE COMMENT 'Calculated Aggregation.',
	DWH_UPDATED COMMENT 'Last Change Date'
) COMMENT='$Revision: 17509 $  1:1 View auf t_agg_str_day_item_pch'
 AS
SELECT
  v.client_id
, v.loc_sid_store
, itmp.item_sid_map    AS item_sid
, sm.container_id 
, sm_hist.container_id	AS container_hist_id
, v.pcwo_reason_id
, v.sfotype_id
, cry.currency_iso_cd
, v.pch_bnl_switch_fg
, v.dwh_cal_dt
, v.val_price_change / CASE WHEN cry.rate_currency_exchange = 0 THEN NULL ELSE cry.rate_currency_exchange END  AS val_price_change
, v.dwh_updated
FROM p_lew_mart_lead.t_agg_str_day_item_pch AS v
 INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
    ON v.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end

 INNER JOIN p_lew_core_ac.v_item_map_key itmp
    ON itmp.client_id = v.client_id
   AND itmp.item_sid  = v.item_sid

LEFT OUTER JOIN p_lew_bil_ac.v_org_store_merge AS osm
ON  v.client_id     = osm.client_id
AND v.loc_sid_store = osm.loc_sid_store
AND osm.aspect_id     = 1   
   
LEFT OUTER JOIN p_lew_BIL_ac.v_sm_map_item_container_str sm
ON v.client_id = sm.client_id
AND v.item_sid = sm.item_sid
AND osm.loc_sid_store_move_to = sm.move_to_store_id
AND CURRENT_DATE BETWEEN sm.dat_rec_start AND sm.dat_rec_end

LEFT OUTER JOIN p_lew_bil_ac.v_sm_map_item_container_str sm_hist
ON v.client_id = sm_hist.client_id
AND v.item_sid = sm_hist.item_sid
AND osm.loc_sid_store_move_to = sm_hist.move_to_store_id
AND v.dwh_cal_dt BETWEEN sm_hist.dat_rec_start AND sm_hist.dat_rec_end
;