/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_mov_storeform_2
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  12.10.2017    Webster,Stuart Adding Columns val_pr_diff_net_sfo and val_pr_diff_sfo o ooo
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  27.06.2018    Taubkin,Slavik           Item_2 Mapping via v_item_2_wawi_item_2
#  1.5  24.07.2018    Michael Ueding           Referenz Item_2 Mapping geaendert
#  1.6  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_2 mit V_WAREHOUSE_2 ersetzt
#  1.7  17.12.2019    Michael Ueding           Ersetzen Legacy mit Core Objekt 
#  1.8  13.01.2020    Ulrich Meister           changed to replace n_-View approach, Patch 20191218_2333_MCD_mart_views_WH_MOVE_DWH20 IDMO-2570, DWH-7995
#  1.2  19.01.2021    Torsten Bachmann         Fix calculation for val_pr_diff_net_sfo
#                                              Patch-No: 2712, REP3-8050
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 16539 $, $LastChangedBy: tbachmann $
#SubjectAreas#: Kleinbelege / Storeforms
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mov_storeform_2
OPTIONS(DESCRIPTION = `NUR WAWI! $Revision: 16539 $. AUTO GENERATED THURSDAY, SEPTEMBER 7, 2017 `) AS
/* Columns val_pr_diff_sfo & val_pr_diff_net_sfo included for patch-1330 */ /* Aufloesung WH */ SELECT MOV.client_id,
 MOV.loc_sid_store AS store_id,
 ITMP.item_sid_map AS item_id,
 MOV.dwh_cal_dt AS dat_formdate,
 MOV.receipt_id AS receipt_id_sfo,
 MOV.receipt_id AS receipt_id_sfo_desc,
 MOV.receipt_pos_nr AS receipt_pos_nr_sfo,
 WH.src_wh_id AS wh_id,
 MOV.dayend_dt AS dat_dayend,
 MOV.sfo_type_id AS sfotype_id,
 MOV.adjustment_seq AS adjustment_cd,
 MOV.subitemgrp_cd AS subitemgroup_id,
 MOV.case_qty AS qty_case_sfo,
 MOV.piece_qty AS qty_piece_sfo,
 MOV.total_qty AS qty_total_sfo,
  CASE
  WHEN MOV.sfo_type_id IN (137, 147, 181, 182, 191, 192) AND (MOV.wh_gross_price <> 0 AND MOV.new_gross_price = 0 OR MOV
       .wh_gross_price = 0 AND MOV.new_gross_price <> 0)
  THEN MOV.total_qty
  ELSE NULL
  END AS qty_total_sfo_wrtoff_zero,
  MOV.receipt_line_gross_val / CRY.rate_currency_exchange AS val_retail_receiptline_sfo,
  MOV.receipt_line_net_val / CRY.rate_currency_exchange AS val_retail_receiptline_net_sfo,
  CASE
  WHEN MOV.sfo_type_id IN (137, 147, 181, 182, 191, 192) AND (MOV.wh_gross_price <> 0 AND MOV.new_gross_price = 0 OR MOV
       .wh_gross_price = 0 AND MOV.new_gross_price <> 0)
  THEN MOV.receipt_line_gross_val / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_wrtoff_zero,
  CASE
  WHEN MOV.sfo_type_id IN (137, 147, 181, 182, 191, 192) AND (MOV.wh_gross_price <> 0 AND MOV.new_gross_price = 0 OR MOV
       .wh_gross_price = 0 AND MOV.new_gross_price <> 0)
  THEN MOV.receipt_line_net_val / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_wrtoff_zero_net,
  MOV.new_gross_price / CRY.rate_currency_exchange AS price_new_sfo,
  MOV.new_net_price / CRY.rate_currency_exchange AS price_new_net_sfo,
  MOV.wh_gross_price / CRY.rate_currency_exchange AS price_wh_sfo,
  MOV.wh_net_price / CRY.rate_currency_exchange AS price_wh_net_sfo,
  MOV.store_gross_price / CRY.rate_currency_exchange AS price_str_sfo,
  MOV.store_net_price / CRY.rate_currency_exchange AS price_str_net_sfo,
  ROUND(CAST(MOV.total_qty * (MOV.store_gross_price - MOV.wh_gross_price) AS NUMERIC), 4) / CRY.rate_currency_exchange
 AS val_pr_diff_sfo,
 CAST(MOV.total_qty * CAST(MOV.store_net_price - MOV.wh_net_price AS BIGNUMERIC) / CRY.rate_currency_exchange AS NUMERIC
  ) AS val_pr_diff_net_sfo,
 MOV.case_size_dec,
 CRY.currency_iso_cd,
 MOV.pcwo_reason_id
FROM ldl_p_lew_core_ac.v_store_form_2 AS MOV
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON MOV.client_id = WH.client_id AND MOV.loc_sid_wh = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON MOV.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON MOV.client_id = ITMP.client_id AND MOV.item_sid = ITMP.item_sid;