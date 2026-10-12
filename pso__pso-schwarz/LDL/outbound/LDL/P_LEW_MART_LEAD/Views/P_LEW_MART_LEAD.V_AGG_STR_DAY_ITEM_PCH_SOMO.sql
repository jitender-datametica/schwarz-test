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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_str_day_item_pch_somo (client_id
OPTIONS(description='The unique identifier for the Lidl country.'), loc_sid_store
OPTIONS(description='surrogate Key for Store.'), item_sid OPTIONS(description='mapped Surrogate Key Item.'),
container_id, container_hist_id, pcwo_reason_id OPTIONS(description='Unique ID for PV >100 local reasons.'), sfotype_id
OPTIONS(description='document type.'), currency_iso_cd OPTIONS(description='Currency .'), pch_bnl_switch_fg
OPTIONS(description='1=calculated with new method.'), dwh_cal_dt OPTIONS(description='Logical Date of Row.'),
val_price_change OPTIONS(description='Calculated Aggregation.'), dwh_updated OPTIONS(description='Last Change Date'))
OPTIONS(DESCRIPTION = `$Revision: 17509 $  1:1 VIEW AUF T_AGG_STR_DAY_ITEM_PCH`) AS SELECT V.client_id,
 V.loc_sid_store,
 ITMP.item_sid_map AS item_sid,
 SM.container_id,
 SM_HIST.container_id AS container_hist_id,
 V.pcwo_reason_id,
 V.sfotype_id,
 CRY.currency_iso_cd,
 V.pch_bnl_switch_fg,
 V.dwh_cal_dt,
  V.val_price_change / CASE
   WHEN CRY.rate_currency_exchange = 0
   THEN NULL
   ELSE CRY.rate_currency_exchange
   END AS val_price_change,
 V.dwh_updated
FROM ldl_p_lew_mart_lead.t_agg_str_day_item_pch AS V
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON V.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON V.client_id = ITMP.client_id AND V.item_sid = ITMP.item_sid
 LEFT JOIN ldl_p_lew_bil_ac.v_org_store_merge AS OSM ON V.client_id = OSM.client_id AND V.loc_sid_store = OSM.loc_sid_store
     AND OSM.aspect_id = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_sm_map_item_container_str AS SM ON V.client_id = SM.client_id AND V.item_sid = SM.item_sid
      AND OSM.loc_sid_store_move_to = SM.move_to_store_id AND CURRENT_DATE BETWEEN SM.dat_rec_start AND SM.dat_rec_end
 LEFT JOIN ldl_p_lew_bil_ac.v_sm_map_item_container_str AS SM_HIST ON V.client_id = SM_HIST.client_id AND V.item_sid =
     SM_HIST.item_sid AND OSM.loc_sid_store_move_to = SM_HIST.move_to_store_id AND V.dwh_cal_dt BETWEEN SM_HIST.dat_rec_start
   AND SM_HIST.dat_rec_end;