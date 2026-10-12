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


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_ROC_STC_BUYING_PRICE_WH_DAY_ITEM
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
  stc.client_id
, wh.src_wh_id                                                 AS wh_id
, stc.loc_sid_wh                                               
, stc.item_sid                                                 
, stc.dwh_cal_dt                                               
, cry.currency_iso_cd                                          AS currency_iso_cd
, roc.qty_piece_stc_wh                                         AS qty_piece_stc_wh_roc
, stc.qty_piece_stc_wh
, rcv.last_buying_price
, (roc.qty_piece_stc_wh * rcv.last_buying_price)::NUMBER(38,5) AS roc_wh_stc_in_buying_price /* BESTAND (incl. RWL filter) in EK*/
, (stc.qty_piece_stc_wh * rcv.last_buying_price)::NUMBER(38,5) AS wh_stc_in_buying_price     /* BESTAND in EK*/
FROM P_LEW_BIL_AC.v_agg_roc_wh_day_item stc
INNER JOIN (SELECT client_id
             ,currency_iso_cd
			 FROM P_LEW_BIL_AC.v_agg_receive_wh_item_day
			 GROUP BY 1,2)cry
        ON stc.client_id = cry.client_id
INNER JOIN p_lew_bil_ac.v_warehouse  wh
        ON  wh.client_id    = stc.client_id
       AND wh.loc_sid_wh    = stc.loc_sid_wh
       AND wh.dwh_actual_fg = 1
       AND wh.bges_active_fg = 1
LEFT JOIN p_lew_mart_msi.v_itm_item_wh_day_roc roc
       ON stc.client_id   = roc.client_id
      AND wh.src_wh_id    = roc.wh_id
      AND stc.item_sid    = roc.item_id
      AND stc.dwh_cal_dt  = roc.dat_formdate
      AND flags_combined  = '0000'
LEFT JOIN 
       (SELECT 
         rcv.client_id
       , rcv.wh_loc_sid
       , itm.item_sid
       , rcv.dwh_cal_dt
       , rcv.currency_iso_cd
       , rcv.last_buying_price
       FROM 
       P_LEW_BIL_AC.v_agg_receive_wh_item_day rcv
       INNER JOIN P_LEW_CORE_AC.v_item itm
               ON itm.client_id = rcv.client_id
              AND TRY_CAST(COALESCE(itm.src_orig_item_nr, itm.config_item_cd, itm.src_matnr) AS NUMBER(18,0)) = rcv.orig_item_nr
       GROUP BY 1,2,3,4,5,6
       )rcv
ON  stc.client_id         = rcv.client_id
AND stc.loc_sid_wh        = rcv.wh_loc_sid
AND stc.item_sid          = rcv.item_sid
AND stc.dwh_cal_dt        = rcv.dwh_cal_dt
AND cry.client_id         = rcv.client_id
AND cry.currency_iso_cd   = rcv.currency_iso_cd
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;
