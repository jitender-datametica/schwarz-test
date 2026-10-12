/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_ROC_STC_BUYING_PRICE_WH_DAY_ITEM
#----------------------------------------------------------------------------
# History:
#  1.0  28.10.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_roc_stc_buying_price_wh_day_item (client_id, wh_id, loc_sid_wh,
item_sid, dwh_cal_dt, currency_iso_cd, qty_piece_stc_wh_roc, qty_piece_stc_wh, last_buying_price,
roc_wh_stc_in_buying_price, wh_stc_in_buying_price) AS /* BESTAND (incl. RWL filter) in EK */ /* BESTAND in EK */ SELECT
 STC.client_id,
 WH.src_wh_id AS wh_id,
 STC.loc_sid_wh,
 STC.item_sid,
 STC.dwh_cal_dt,
 cry.currency_iso_cd,
 ROC.qty_piece_stc_wh AS qty_piece_stc_wh_roc,
 ROC.qty_piece_stc_wh,
 ROUND(CAST(ROC.qty_piece_stc_wh * rcv.last_buying_price AS BIGNUMERIC), 5) AS last_buying_price,
 ROUND(CAST(ROC.qty_piece_stc_wh * rcv.last_buying_price AS BIGNUMERIC), 5) AS roc_wh_stc_in_buying_price,
 ROUND(CAST(STC.qty_piece_stc_wh * rcv.last_buying_price AS BIGNUMERIC), 5) AS wh_stc_in_buying_price
FROM ldl_p_lew_bil_ac.v_agg_roc_wh_day_item AS STC
 INNER JOIN (SELECT client_id,
   currency_iso_cd
  FROM ldl_p_lew_bil_ac.v_agg_receive_wh_item_day
  GROUP BY client_id,
   currency_iso_cd) AS cry ON STC.client_id = cry.client_id
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON STC.client_id = WH.client_id AND STC.loc_sid_wh = WH.loc_sid_wh AND WH
    .dwh_actual_fg = 1 AND WH.bges_active_fg = 1
 LEFT JOIN ldl_p_lew_mart_msi.v_itm_item_wh_day_roc AS ROC ON STC.client_id = ROC.client_id AND WH.src_wh_id = ROC.wh_id
       AND STC.item_sid = ROC.item_id AND STC.dwh_cal_dt = ROC.dat_formdate AND ROC.flags_combined = '0000'
 LEFT JOIN (SELECT RCV.client_id,
   RCV.wh_loc_sid,
   ITM.item_sid,
   RCV.dwh_cal_dt,
   RCV.currency_iso_cd,
   RCV.last_buying_price
  FROM ldl_p_lew_bil_ac.v_agg_receive_wh_item_day AS RCV
   INNER JOIN ldl_p_lew_core_ac.v_item AS ITM ON RCV.client_id = ITM.client_id AND ROUND(SAFE_CAST(COALESCE(ITM.src_orig_item_nr
        , ITM.config_item_cd, ITM.src_matnr) AS BIGNUMERIC), 0) = RCV.orig_item_nr
  GROUP BY RCV.client_id,
   RCV.wh_loc_sid,
   ITM.item_sid,
   RCV.dwh_cal_dt,
   RCV.currency_iso_cd,
   RCV.last_buying_price) AS rcv ON STC.client_id = rcv.client_id AND STC.loc_sid_wh = rcv.wh_loc_sid AND STC.item_sid =
      rcv.item_sid AND STC.dwh_cal_dt = rcv.dwh_cal_dt AND cry.client_id = rcv.client_id AND cry.currency_iso_cd = rcv.currency_iso_cd
   
GROUP BY STC.client_id,
 wh_id,
 STC.loc_sid_wh,
 STC.item_sid,
 STC.dwh_cal_dt,
 cry.currency_iso_cd,
 qty_piece_stc_wh_roc,
 STC.qty_piece_stc_wh,
 rcv.last_buying_price,
 roc_wh_stc_in_buying_price,
 wh_stc_in_buying_price;