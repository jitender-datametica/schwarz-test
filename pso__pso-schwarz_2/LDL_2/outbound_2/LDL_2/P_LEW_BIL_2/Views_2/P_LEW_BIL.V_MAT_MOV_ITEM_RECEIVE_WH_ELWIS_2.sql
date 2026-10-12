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
#  2.9  15.11.2023    Torsten Bachmann     To save resources it was decided to exclude eLwis data from original view. To save the logic in case we need to reload hist data,
#                                          eLwis logic is stored in a separate view.
#----------------------------------------------------------------------------
*/



/*
#----------------------------------------------------------------------------
*/


/* eLWIS-Daten */ CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_mov_item_receive_wh_elwis_2
OPTIONS(DESCRIPTION = `ORIGNIAL VIEW: P_LEW_BIL.V_MAT_MOV_ITEM_RECEIVE_WH_2`) AS
/* Auf COEX-Seite wird zweimal gruppiert, was überflüssig ist, weshalb für den Neubau auf DWH-Seite nur eine_2 Gruppierung erfolgt
     was zu Performancegewinnen führt und besseres Design ist.
     Auf COEX-Seite wird zuerst nach client_id, location_item_receipt_year, location_item_receipt_id, bwcounter und curr_cd_receipt gruppiert.
     Was der Granularität der Tabelle T_LOCATION_ITEM_RECEIPT_2 entspricht. Allerdings werden bei der anschließenden zweiten Gruppierung die
     Informationen bwcounter und curr_cd_receipt nicht beachtet, sodass die Kennzahlen in der Tabelle T_LOCATION_ITEM_RECEIPT_2 auf der Granularitätsebene
     client_id, location_item_receipt_year, location_item_receipt_id aggregiert werden. Deshalb kann dies in einem Schritt erfolgen. */
/* Auflösung WH */ /* Internationale Itemgroup_2 bestimmen */ SELECT lir.client_id,
 lir.loc_sid_wh,
 LOC_WH.src_wh_id,
 lir.item_sid,
 lir.dwh_cal_dt,
 CAST(NULL AS STRING) AS customer_nr,
 lir.location_item_receipt_id,
 lir.location_item_receipt_pos_id,
  CASE
  WHEN lir.ledger_account_nr = '326010-R' AND dmy_receipt_type_ids.receipt_type_id = 1
  THEN 6
  WHEN lir.ledger_account_nr = '326010-R' AND dmy_receipt_type_ids.receipt_type_id = 4
  THEN 7
  WHEN lir.ledger_account_nr = '326010-R' AND dmy_receipt_type_ids.receipt_type_id = 5
  THEN 8
  ELSE dmy_receipt_type_ids.receipt_type_id
  END AS receipt_type_id,
 CAST(NULL AS BIGNUMERIC) AS currency_id,
 DATE(NULL) AS dat_dayend,
 lir.dwh_cal_dt AS entry_dt,
 DATE(NULL) AS dat_adjustment_rcv,
 DATE(NULL) AS dat_min_durability_rcv,
 DATE(NULL) AS dat_valid_from,
 DATE(NULL) AS dat_valid_until,
 lir.sup_sid,
 CAST(NULL AS BIGNUMERIC) AS sup_sid_pay,
 CAST(NULL AS BIGNUMERIC) AS mapping_pos_nr,
 CAST(NULL AS STRING) AS orig_receipt_id_rcv,
 CAST(NULL AS BIGNUMERIC) AS receipt_pos_partdel_fg,
 CAST(NULL AS BIGNUMERIC) AS receipt_pos_matchable_rel_fg,
 1 AS receipt_pos_margin_rel_fg,
 99 AS status_tg,
 CAST(NULL AS BIGNUMERIC) AS vat_id,
 CAST(NULL AS NUMERIC) AS pct_vat_rcv,
 CAST(NULL AS BIGNUMERIC) AS item_category_id,
 CAST(NULL AS BIGNUMERIC) AS stock_location_nr,
 lir.receive_case_qty,
 CAST(NULL AS NUMERIC) AS qty_piece_rcv,
 lir.receive_piece_qty,
 CAST(NULL AS NUMERIC) AS price_buying_rcv,
 CAST(NULL AS NUMERIC) AS price_buying_euro_rcv,
 CAST(NULL AS NUMERIC) AS price_retail_rcv,
 CAST(NULL AS NUMERIC) AS price_retail_net_rcv,
   CASE
   WHEN dmy_receipt_type_ids.receipt_type_id = 1
   THEN lir.pur_development_net_val
   WHEN dmy_receipt_type_ids.receipt_type_id = 4
   THEN lir.carrier_costs_val - lir.refunds_val
   WHEN dmy_receipt_type_ids.receipt_type_id = 5
   THEN lir.tax_val + lir.environmental_levies_val + lir.customs_val
   ELSE NULL
   END / ERKH.exchange_rate AS buying_val,
 CAST(NULL AS NUMERIC) AS val_buying_suppl_rcv,
 CAST(NULL AS NUMERIC) AS val_buying_euro,
 CAST(CASE
    WHEN dmy_receipt_type_ids.receipt_type_id = 1
    THEN lir.sales_gross_val
    ELSE NULL
    END / ERKH.exchange_rate AS NUMERIC) AS retail_val,
 CAST(CASE
    WHEN dmy_receipt_type_ids.receipt_type_id = 1
    THEN lir.sales_net_val
    ELSE NULL
    END / ERKH.exchange_rate AS NUMERIC) AS retail_net_val,
 CAST(NULL AS NUMERIC) AS val_deposit_rcv,
 CAST(NULL AS NUMERIC) AS case_size_dec,
 CAST(NULL AS BIGNUMERIC) AS package_qty,
 CAST(CASE
   WHEN CAST(ITIN.src_itemgrp_int_cd AS INTEGER) NOT IN (1, 10, 7, 70) AND lir.list_type_cd = 'A'
   THEN CASE
     WHEN dmy_receipt_type_ids.receipt_type_id = 1
     THEN lir.pur_development_net_val
     WHEN dmy_receipt_type_ids.receipt_type_id = 4
     THEN lir.carrier_costs_val - lir.refunds_val
     WHEN dmy_receipt_type_ids.receipt_type_id = 5
     THEN lir.tax_val + lir.environmental_levies_val + lir.customs_val
     ELSE NULL
     END / ERKH.exchange_rate
   ELSE NULL
   END AS NUMERIC) AS buying_fa_val,
 CAST(CASE
    WHEN dmy_receipt_type_ids.receipt_type_id = 1 AND lir.list_type_cd = 'A' AND CAST(ITIN.src_itemgrp_int_cd AS INTEGER)
      NOT IN (1, 10, 7, 70)
    THEN lir.sales_net_val
    ELSE NULL
    END / ERKH.exchange_rate AS NUMERIC) AS retail_net_fa_val,
 ERKH.curr_cd_from
FROM (SELECT LIR.client_id,
   LIR.location_item_receipt_year,
   LIR.location_item_receipt_id,
   LIR.location_item_receipt_pos_id,
   MAX(LIR.loc_sid_wh) AS loc_sid_wh,
   MAX(LIR.item_sid) AS item_sid,
   MAX(ITEM.item_grp_int_sid_asis) AS item_grp_int_sid_asis,
   MAX(LIR.dwh_cal_dt) AS dwh_cal_dt,
   MAX(LIR.sup_sid) AS sup_sid,
   MAX(LIR.ledger_account_cd) AS ledger_account_nr,
   MAX(LIR.list_type_mark) AS list_type_cd,
   SUM(LIR.receive_case_qty) AS receive_case_qty,
   SUM(LIR.receive_piece_qty) AS receive_piece_qty,
   SUM(LIR.pur_development_net_val) AS pur_development_net_val,
   SUM(LIR.carrier_costs_val) AS carrier_costs_val,
   SUM(LIR.refunds_val) AS refunds_val,
   SUM(LIR.tax_val) AS tax_val,
   SUM(LIR.environmental_levies_val) AS environmental_levies_val,
   SUM(LIR.customs_val) AS customs_val,
   SUM(LIR.sales_gross_val) AS sales_gross_val,
   SUM(LIR.sales_net_val) AS sales_net_val
  FROM ldl_p_lew_core_ac.v_location_item_receipt_2 AS LIR
   INNER JOIN ldl_p_lew_bil_ac.v_item_2 AS ITEM_2 ON LIR.client_id = ITEM.client_id AND LIR.item_sid = ITEM.item_sid AND
     ITEM.dwh_actual_fg = 1
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS M ON LIR.client_id = M.client_id AND LIR.dwh_cal_dt BETWEEN M
     .migration_dat_valid_from AND M.migration_dat_valid_to /* eLWIS Laender */
     /* Nur Daten der letzten 40 Monate anzeigen */
  WHERE LIR.dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 40 MONTH)
      ), DATE_ADD(CURRENT_DATE, INTERVAL - 40 MONTH))
  GROUP BY LIR.client_id,
   LIR.location_item_receipt_year,
   LIR.location_item_receipt_id,
   LIR.location_item_receipt_pos_id) AS lir
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC_WH ON lir.client_id = LOC_WH.client_id AND lir.loc_sid_wh = LOC_WH.loc_sid
     AND UPPER(LOC_WH.wh_store_mark) = 'B' /* WHs */ /* Währung bestimmen */
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS ERKH ON lir.client_id = ERKH.client_id AND CURRENT_DATE
    BETWEEN ERKH.active_from_dt AND ERKH.active_to_dt AND CURRENT_DATE BETWEEN ERKH.dwh_valid_from AND ERKH.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS ERT ON ERKH.client_id = ERT.client_id AND ERKH.x_rate_type_sid =
    ERT.x_rate_type_sid AND ERT.src_kurst = '@BEWE' /* Generiere DMY receipt_type_ids */
 INNER JOIN (SELECT 1 AS receipt_type_id
   UNION ALL
   SELECT 4 AS receipt_type_id
   UNION ALL
   SELECT 5 AS receipt_type_id) AS dmy_receipt_type_ids ON TRUE
 LEFT JOIN ldl_p_lew_bil_ac.v_itemgroup_international_2 AS ITIN ON lir.client_id = ITIN.client_id AND lir.item_grp_int_sid_asis
    = ITIN.item_grp_int_sid;