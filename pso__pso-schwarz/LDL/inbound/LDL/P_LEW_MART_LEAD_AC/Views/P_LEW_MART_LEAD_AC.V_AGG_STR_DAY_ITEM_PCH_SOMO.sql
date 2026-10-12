/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_STR_DAY_ITEM_PCH
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2022    Białek, Aleksander        Implementing Container context (part of Sortimentmodularity, AzureDevops: US 298238, BBT-3750, AP0101040)
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STR_DAY_ITEM_PCH_SOMO (
  CLIENT_ID
, LOC_SID_STORE
, ITEM_SID
, CONTAINER_ID 
, CONTAINER_HIST_ID	
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
, v.container_id 
, v.container_hist_id	
, v.pcwo_reason_id
, v.sfotype_id
, v.currency_iso_cd
, v.pch_bnl_switch_fg
, v.dwh_cal_dt
, v.val_price_change
, v.dwh_updated
FROM P_LEW_MART_LEAD.V_AGG_STR_DAY_ITEM_PCH_SOMO AS v
;