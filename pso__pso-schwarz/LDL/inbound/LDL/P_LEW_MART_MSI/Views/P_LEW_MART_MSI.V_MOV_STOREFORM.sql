/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_mov_storeform
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  12.10.2017    Webster,Stuart Adding Columns val_pr_diff_net_sfo and val_pr_diff_sfo o ooo
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  27.06.2018    Taubkin,Slavik           Item Mapping via v_item_2_wawi_item
#  1.5  24.07.2018    Michael Ueding           Referenz Item Mapping geaendert
#  1.6  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY mit V_WAREHOUSE ersetzt
#  1.7  17.12.2019    Michael Ueding           Ersetzen Legacy mit Core Objekt 
#  1.8  13.01.2020    Ulrich Meister           changed to replace n_-View approach, Patch 20191218_2333_MCD_mart_views_WH_MOVE_DWH20 IDMO-2570, DWH-7995
#  1.2  19.01.2021    Torsten Bachmann         Fix calculation for val_pr_diff_net_sfo
#                                              Patch-No: 2712, REP3-8050
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MOV_STOREFORM
COMMENT = 'Nur Wawi! $Revision: 16539 $. Auto Generated Thursday, September 7, 2017 '
AS
/*
#DescStart#
#$Revision: 16539 $, $LastChangedBy: tbachmann $
#SubjectAreas#: Kleinbelege / Storeforms
#DescEnd#
*/
SELECT
   mov.client_id
  ,mov.loc_sid_store AS store_id
  ,itmp.item_sid_map AS item_id
  ,mov.dwh_cal_dt AS dat_formdate
  ,mov.receipt_id AS receipt_id_sfo
  ,mov.receipt_id AS receipt_id_sfo_desc
  ,mov.receipt_pos_nr AS receipt_pos_nr_sfo
  ,wh.src_wh_id AS wh_id
  ,mov.dayend_dt AS dat_dayend
  ,mov.sfo_type_id AS sfotype_id
  ,mov.adjustment_seq AS  adjustment_cd
  ,mov.subitemgrp_cd AS subitemgroup_id
  ,mov.case_qty AS qty_case_sfo
  ,mov.piece_qty AS qty_piece_sfo
  ,mov.total_qty AS qty_total_sfo
  ,CASE WHEN mov.sfo_type_id IN (137,147,181,182,191,192) AND ((mov.wh_gross_price <> 0 AND mov.new_gross_price = 0) OR (mov.wh_gross_price = 0 AND mov.new_gross_price <> 0))
        THEN mov.total_qty 
        ELSE NULL
   END AS qty_total_sfo_wrtoff_zero
  ,mov.receipt_line_gross_val / cry.rate_currency_exchange     AS val_retail_receiptline_sfo
  ,mov.receipt_line_net_val / cry.rate_currency_exchange     AS val_retail_receiptline_net_sfo
  ,CASE WHEN mov.sfo_type_id IN (137,147,181,182,191,192) AND ((mov.wh_gross_price <> 0 AND mov.new_gross_price = 0) OR (mov.wh_gross_price = 0 AND mov.new_gross_price <> 0))
        THEN mov.receipt_line_gross_val / cry.rate_currency_exchange 
        ELSE NULL
   END AS val_wrtoff_zero
  ,CASE WHEN mov.sfo_type_id IN (137,147,181,182,191,192) AND ((mov.wh_gross_price <> 0 AND mov.new_gross_price = 0) OR (mov.wh_gross_price = 0 AND mov.new_gross_price <> 0))
        THEN mov.receipt_line_net_val / cry.rate_currency_exchange  
        ELSE NULL
   END AS val_wrtoff_zero_net
  ,mov.new_gross_price / cry.rate_currency_exchange     AS price_new_sfo
  ,mov.new_net_price / cry.rate_currency_exchange AS price_new_net_sfo
  ,mov.wh_gross_price / cry.rate_currency_exchange      AS price_wh_sfo
  ,mov.wh_net_price/ cry.rate_currency_exchange   AS price_wh_net_sfo
  ,mov.store_gross_price / cry.rate_currency_exchange     AS price_str_sfo
  ,mov.store_net_price/ cry.rate_currency_exchange  AS price_str_net_sfo

   /* Columns val_pr_diff_sfo & val_pr_diff_net_sfo included for patch-1330 */
  ,Cast(mov.total_qty * (mov.store_gross_price - mov.wh_gross_price)AS DECIMAL(18,4)) / cry.rate_currency_exchange AS val_pr_diff_sfo
  ,Cast(mov.total_qty * CAST ((mov.store_net_price - mov.wh_net_price) AS DECIMAL(38,5)) / cry.rate_currency_exchange AS DECIMAL(19,5)) AS val_pr_diff_net_sfo

  ,mov.case_size_dec
  ,cry.currency_iso_cd
  ,mov.pcwo_reason_id
FROM P_LEW_CORE_AC.v_store_form AS mov

/* Aufloesung WH */
INNER JOIN P_LEW_BIL_AC.v_warehouse AS wh
ON wh.client_id = mov.client_id
  AND wh.loc_sid_wh = mov.loc_sid_wh
  AND wh.dwh_actual_fg = 1

INNER JOIN P_LEW_CORE_AC.v_wawi_ref_client_currency_rate AS cry
ON mov.client_id = cry.client_id
  AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

INNER JOIN P_LEW_CORE_AC.v_item_map_key AS itmp
ON itmp.client_id = mov.client_id
  AND itmp.item_sid = mov.item_sid
;

