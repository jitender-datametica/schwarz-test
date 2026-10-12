/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_STR_DAY_ITEM_PCH_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2022    Białek, Aleksander        Implementing Container context (part of Sortimentmodularity, AzureDevops: US 298238, BBT-3750, AP0101040)
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_str_day_item_pch_somo_2 (client_id, loc_sid_store, item_sid,
container_id, container_hist_id, pcwo_reason_id, sfotype_id, currency_iso_cd, pch_bnl_switch_fg, dwh_cal_dt,
val_price_change, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_str_day_item_pch_somo_2 AS V;