/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_STR_DAY_ITEM_PCH
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2022    Białek, Aleksander        Implementing Container context (part of Sortimentmodularity, AzureDevops: US 298238, BBT-3750, AP0101040)
#  1.1  27.04.2023    Białek, Aleksander        ADO_WI:470334 Removal of Container and Container_hist ids along with removing them from the p_lew_mart_lead.v_agg_str_day_item_pch 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STR_DAY_ITEM_PCH (
  CLIENT_ID
, LOC_SID_STORE
, ITEM_SID
, PCWO_REASON_ID
, SFOTYPE_ID
, CURRENCY_ISO_CD
, PCH_BNL_SWITCH_FG
, DWH_CAL_DT
, VAL_PRICE_CHANGE
, DWH_UPDATED
) AS
SELECT
  v.client_id
, v.loc_sid_store
, v.item_sid
, v.pcwo_reason_id
, v.sfotype_id
, v.currency_iso_cd
, v.pch_bnl_switch_fg
, v.dwh_cal_dt
, v.val_price_change
, v.dwh_updated
FROM p_lew_mart_lead.v_agg_str_day_item_pch AS v
;