/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_STR_DAY_ITEM_PCH_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2022    Białek, Aleksander        Implementing Container context (part of Sortimentmodularity, AzureDevops: US 298238, BBT-3750, AP0101040)
#  1.1  27.04.2023    Białek, Aleksander        ADO_WI:470334 Removal of Container and Container_hist ids along with removing them from the p_lew_mart_lead.v_agg_str_day_item_pch_1 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_str_day_item_pch_1 (client_id, loc_sid_store, item_sid, pcwo_reason_id
, sfotype_id, currency_iso_cd, pch_bnl_switch_fg, dwh_cal_dt, val_price_change, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_str_day_item_pch_1 AS V;