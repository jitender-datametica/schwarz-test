/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_ROC_STC_BUYING_PRICE_WH_DAY_ITEM_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.10.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_roc_stc_buying_price_wh_day_item_2 (client_id, wh_id, loc_sid_wh,
item_sid, dwh_cal_dt, currency_iso_cd, qty_piece_stc_wh_roc, qty_piece_stc_wh, last_buying_price,
roc_wh_stc_in_buying_price, wh_stc_in_buying_price) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_roc_stc_buying_price_wh_day_item_2;