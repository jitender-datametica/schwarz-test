/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber,Harald        Release 1.1
#  1.1  16.11.2017    Wieber,Harald        Relese 1.1 v2
#  1.2  20.11.2017    Wieber,Harald        Set CommentString to MAX length 255
#  1.3  20.11.2017    Wieber,Harald        Set CommentString to MAX length 255
#  1.4  20.11.2017    Wieber,Harald        Set CommentString to MAX length 255 (Fix 3)
#  1.5  20.11.2017    Wieber,Harald        Correct SVN File
#  1.6  20.11.2017    Wieber,Harald        Eliminate circular access to lew_bil_ac
#  1.7  20.11.2017    Arnold,Arne          Aufnahme neuer Spalten
#  1.8  21.11.2017    Arnold,Arne          Anpassung Gruppierung und Spaltennamenumbenennung.
#  1.9  27.11.2017    Arnold,Arne          Gruppierung im Subselect aktualisiert und Datenformat für zwei Kennzahlen angepasst.
#  2.1  05.12.2017    Arnold,Arne          Anpassung der Spaltennamen an Entwicklerrichtlinien
#  2.2  12.12.2017    Arnold,Arne          Spalte SRC_FG aufgenommen.
#  2.3  09.01.2018    Arnold,Arne          Spalte SRC_FG wieder entfernt
#  2.4  15.05.2018    Michael Ueding       Filter auf Zahlenwerte > NUMBER(18,5)
#  2.5  25.07.2019    Michael Ueding       Abgrenzung Daten aufgrund AT Wawi Rollback
#  2.6  28.08.2019    Michael Ueding       fuer Wawi: Abgrenzung ueber dat_entry_rcv
#  2.7  22.10.2019    Wieber, Harald       Code Review
#  2.8  2020-12-30    Michal Malinowski    20201214_2691_Frischfish_adjustments, REP3-7935
#                                          FrischFish WGI ID Conversion (3=>30,32) && (i(1,2,4,5,6,7,8,9)=>(i*10...)
#  2.9  14.11.2023    Torsten Bachmann     To save resources it was decided to exclude eLwis data from this view, because it won't change anymore.
#                                          So, there is no need to recalculate this data every day.
#----------------------------------------------------------------------------
*/



/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_mov_item_receive_wh_1 OPTIONS(DESCRIPTION = `$Revision: 16839 $ `) AS SELECT
 RCV.client_id,
 RCV.wh_loc_sid AS loc_sid_wh,
 LOC_WH.src_wh_id,
 RCV.item_sid,
 RCV.dat_formdate AS dwh_cal_dt,
 RCV.customer_nr,
 RCV.receipt_id_rcv AS location_item_receipt_id,
 RCV.receipt_pos_nr_rcv AS location_item_receipt_pos_id,
 RCV.receipttype_id AS receipt_type_id,
 RCV.currency_id,
 RCV.dat_dayend,
 RCV.dat_entry_rcv AS entry_dt,
 RCV.dat_adjustment_rcv,
 RCV.dat_min_durability_rcv,
 RCV.dat_valid_from,
 RCV.dat_valid_until,
 RCV.sup_sid,
 RCV.sup_sid_pay,
 RCV.mapping_pos_nr,
 RCV.orig_receipt_id_rcv,
 RCV.receipt_pos_partdel_fg,
 RCV.receipt_pos_matchable_rel_fg,
 RCV.receipt_pos_margin_rel_fg,
 RCV.status_tg,
 RCV.vat_id,
 RCV.pct_vat_rcv,
 RCV.item_category_id,
 RCV.stock_location_nr,
 RCV.qty_case_rcv AS receive_case_qty,
 RCV.qty_piece_rcv,
 RCV.qty_total_rcv AS receive_piece_qty,
  RCV.price_buying_rcv / ERKH.exchange_rate AS price_buying_rcv,
 RCV.price_buying_euro_rcv,
  RCV.price_retail_rcv / ERKH.exchange_rate AS price_retail_rcv,
  RCV.price_retail_net_rcv / ERKH.exchange_rate AS price_retail_net_rcv,
  RCV.val_buying_rcv / ERKH.exchange_rate AS buying_val,
 RCV.val_buying_sup_rcv AS val_buying_suppl_rcv,
 RCV.val_buying_euro,
  RCV.val_retail_rcv / ERKH.exchange_rate AS retail_val,
  RCV.val_net_retail_rcv / ERKH.exchange_rate AS retail_net_val,
  RCV.val_deposit_rcv / ERKH.exchange_rate AS val_deposit_rcv,
 RCV.case_size_dec,
 RCV.package_qty,
  CASE
  WHEN FA.client_id IS NOT NULL
  THEN RCV.val_buying_rcv / ERKH.exchange_rate
  ELSE NULL
  END AS buying_fa_val,
  CASE
  WHEN FA.client_id IS NOT NULL
  THEN RCV.val_net_retail_rcv / ERKH.exchange_rate
  ELSE NULL
  END AS retail_net_fa_val,
 ERKH.curr_cd_from
FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving_1 AS RCV
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS M ON RCV.client_id = M.client_id AND (RCV.dat_entry_rcv < M.migration_dat_valid_from
      OR RCV.dat_entry_rcv > M.migration_dat_valid_to)
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC_WH ON RCV.client_id = LOC_WH.client_id AND RCV.wh_loc_sid = LOC_WH.loc_sid
     AND UPPER(LOC_WH.wh_store_mark) = 'B'
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS ERKH ON RCV.client_id = ERKH.client_id AND CURRENT_DATE
    BETWEEN ERKH.active_from_dt AND ERKH.active_to_dt AND CURRENT_DATE BETWEEN ERKH.dwh_valid_from AND ERKH.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS ERT ON ERKH.client_id = ERT.client_id AND ERKH.x_rate_type_sid =
    ERT.x_rate_type_sid AND ERT.src_kurst = '@BEWE'
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_foodaction_asws_act_1 AS FA ON RCV.client_id = FA.client_id AND RCV.item_sid
    = FA.item_sid AND RCV.dat_entry_rcv = FA.dat_valid
WHERE RCV.dat_entry_rcv > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 40 MONTH)
    ), DATE_ADD(CURRENT_DATE, INTERVAL - 40 MONTH));