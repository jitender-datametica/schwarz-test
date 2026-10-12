/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_ROC_STC_BUYING_PRICE_WH_DAY_ITEM
#----------------------------------------------------------------------------
# History:
#  1.0  28.10.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_ROC_STC_BUYING_PRICE_WH_DAY_ITEM
(
  client_id
, wh_id
, loc_sid_wh
, item_sid
, dwh_cal_dt
, currency_iso_cd
, qty_piece_stc_wh_roc
, qty_piece_stc_wh
, last_buying_price
, roc_wh_stc_in_buying_price
, wh_stc_in_buying_price
) AS
SELECT 
  client_id
, wh_id
, loc_sid_wh
, item_sid
, dwh_cal_dt
, currency_iso_cd
, qty_piece_stc_wh_roc
, qty_piece_stc_wh
, last_buying_price
, roc_wh_stc_in_buying_price
, wh_stc_in_buying_price
FROM P_LEW_MART_LEAD.V_AGG_ROC_STC_BUYING_PRICE_WH_DAY_ITEM
;

