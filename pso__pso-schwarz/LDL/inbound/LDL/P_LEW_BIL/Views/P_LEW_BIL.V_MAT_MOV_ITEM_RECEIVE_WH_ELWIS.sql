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
#  2.4  15.05.2018    Michael Ueding       Filter auf Zahlenwerte > Decimal(18,5)
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

CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_MOV_ITEM_RECEIVE_WH_ELWIS
COMMENT = 'Orignial View: P_LEW_BIL.V_MAT_MOV_ITEM_RECEIVE_WH'

AS
/* eLWIS-Daten */
SELECT
   lir.client_id
  ,lir.loc_sid_wh
  ,loc_wh.src_wh_id
  ,lir.item_sid
  ,lir.dwh_cal_dt
  ,CAST(NULL AS VARCHAR(5)) AS customer_nr
  ,lir.location_item_receipt_id AS location_item_receipt_id
  ,lir.location_item_receipt_pos_id AS location_item_receipt_pos_id
  ,CASE
     WHEN lir.ledger_account_nr = '326010-R'  AND dmy_receipt_type_ids.receipt_type_id = 1 THEN  6
     WHEN lir.ledger_account_nr = '326010-R'  AND dmy_receipt_type_ids.receipt_type_id = 4 THEN  7
     WHEN lir.ledger_account_nr = '326010-R'  AND dmy_receipt_type_ids.receipt_type_id = 5 THEN  8
     ELSE dmy_receipt_type_ids.receipt_type_id
   END AS receipt_type_id
  ,CAST(NULL AS SMALLINT) AS currency_id
  ,CAST(NULL AS DATE) AS dat_dayend
  ,lir.dwh_cal_dt AS entry_dt
  ,CAST(NULL AS DATE) AS dat_adjustment_rcv
  ,CAST(NULL AS DATE) AS dat_min_durability_rcv
  ,CAST(NULL AS DATE) AS dat_valid_from
  ,CAST(NULL AS DATE) AS  dat_valid_until
  ,lir.sup_sid AS sup_sid
  ,CAST(NULL AS INTEGER) AS sup_sid_pay
  ,CAST(NULL AS DECIMAL(15,0)) AS mapping_pos_nr
  ,CAST(NULL AS VARCHAR(60)) AS orig_receipt_id_rcv
  ,CAST(NULL AS SMALLINT) AS receipt_pos_partdel_fg
  ,CAST(NULL AS SMALLINT) AS receipt_pos_matchable_rel_fg
  ,1 AS receipt_pos_margin_rel_fg
  ,99 AS status_tg
  ,CAST(NULL AS INTEGER) AS vat_id
  ,CAST(NULL AS DECIMAL(18,4)) AS pct_vat_rcv
  ,CAST(NULL AS INTEGER) AS item_category_id
  ,CAST(NULL AS INTEGER) AS stock_location_nr
  ,lir.receive_case_qty
  ,CAST(NULL AS DECIMAL(18,4)) AS qty_piece_rcv
  ,lir.receive_piece_qty AS receive_piece_qty
  ,CAST(NULL AS DECIMAL(18,4)) AS price_buying_rcv
  ,CAST(NULL AS DECIMAL(18,4)) AS price_buying_euro_rcv
  ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_rcv
  ,CAST(NULL AS DECIMAL(19,5)) AS price_retail_net_rcv
  ,CASE
     WHEN dmy_receipt_type_ids.receipt_type_id = 1 THEN lir.pur_development_net_val
     WHEN dmy_receipt_type_ids.receipt_type_id = 4 THEN lir.carrier_costs_val - lir.refunds_val
     WHEN dmy_receipt_type_ids.receipt_type_id = 5 THEN lir.tax_val + lir.environmental_levies_val + lir.customs_val
   END / erkh.exchange_rate AS buying_val
  ,CAST(NULL AS DECIMAL(18,4)) AS val_buying_suppl_rcv
  ,CAST(NULL AS DECIMAL(18,4)) AS val_buying_euro
  ,CAST(CASE
     WHEN dmy_receipt_type_ids.receipt_type_id = 1 THEN lir.sales_gross_val
     ELSE NULL
   END / erkh.exchange_rate AS DECIMAL(18,4)) AS retail_val
  ,CAST(CASE
     WHEN dmy_receipt_type_ids.receipt_type_id = 1 THEN lir.sales_net_val
     ELSE NULL
   END / erkh.exchange_rate AS DECIMAL(18,4)) AS retail_net_val
  ,CAST(NULL AS DECIMAL(18,4)) AS val_deposit_rcv
  ,CAST(NULL AS DECIMAL(9,4)) AS case_size_dec
  ,CAST(NULL AS INTEGER) AS package_qty
  ,CAST(CASE
     WHEN itin.src_itemgrp_int_cd NOT IN (1, 10, 7, 70) AND  lir.list_type_cd = 'A' THEN buying_val
     ELSE NULL
   END AS DECIMAL(18,4)) AS buying_fa_val
  ,CAST(CASE
     WHEN dmy_receipt_type_ids.receipt_type_id = 1 AND itin.src_itemgrp_int_cd NOT IN (1, 10, 7, 70) AND lir.list_type_cd = 'A' THEN lir.sales_net_val
     ELSE NULL
   END / erkh.exchange_rate AS DECIMAL(18,4)) AS retail_net_fa_val
  ,erkh.curr_cd_from AS curr_cd_from
FROM
(
  /* Auf COEX-Seite wird zweimal gruppiert, was überflüssig ist, weshalb für den Neubau auf DWH-Seite nur eine Gruppierung erfolgt
     was zu Performancegewinnen führt und besseres Design ist.
     Auf COEX-Seite wird zuerst nach client_id, location_item_receipt_year, location_item_receipt_id, bwcounter und curr_cd_receipt gruppiert.
     Was der Granularität der Tabelle T_LOCATION_ITEM_RECEIPT entspricht. Allerdings werden bei der anschließenden zweiten Gruppierung die
     Informationen bwcounter und curr_cd_receipt nicht beachtet, sodass die Kennzahlen in der Tabelle T_LOCATION_ITEM_RECEIPT auf der Granularitätsebene
     client_id, location_item_receipt_year, location_item_receipt_id aggregiert werden. Deshalb kann dies in einem Schritt erfolgen.
  */
  SELECT
     lir.client_id
    ,lir.location_item_receipt_year
    ,lir.location_item_receipt_id
    ,lir.location_item_receipt_pos_id
    ,MAX(lir.loc_sid_wh) AS loc_sid_wh
    ,MAX(lir.item_sid) AS item_sid
    ,MAX(item.item_grp_int_sid_asis) AS item_grp_int_sid_asis
    ,MAX(lir.dwh_cal_dt) AS dwh_cal_dt
    ,MAX(lir.sup_sid) AS sup_sid
    ,MAX(lir.ledger_account_cd) AS ledger_account_nr
    ,MAX(lir.list_type_mark) AS list_type_cd
    ,SUM(lir.receive_case_qty) AS receive_case_qty
    ,SUM(lir.receive_piece_qty) AS receive_piece_qty
    ,SUM(lir.pur_development_net_val) AS pur_development_net_val
    ,SUM(lir.carrier_costs_val) AS carrier_costs_val
    ,SUM(lir.refunds_val) AS refunds_val
    ,SUM(lir.tax_val) AS tax_val
    ,SUM(lir.environmental_levies_val) AS environmental_levies_val
    ,SUM(lir.customs_val) AS customs_val
    ,SUM(lir.sales_gross_val) AS sales_gross_val
    ,SUM(lir.sales_net_val) AS sales_net_val
  FROM P_LEW_CORE_AC.v_location_item_receipt AS lir

  INNER JOIN P_LEW_BIL_AC.v_item AS item
  ON lir.client_id = item.client_id
    AND lir.item_sid = item.item_sid
    AND item.dwh_actual_fg = 1

  INNER JOIN P_LEW_CORE_AC.v_client_migration_per m
  ON lir.client_id = m.client_id
    AND lir.dwh_cal_dt BETWEEN m.migration_dat_valid_from AND m.migration_dat_valid_to /* eLWIS Laender */

  /* Nur Daten der letzten 40 Monate anzeigen */
  WHERE lir.dwh_cal_dt > ADD_MONTHS(Current_Date, -40)

  GROUP BY
     lir.client_id
    ,lir.location_item_receipt_year
    ,lir.location_item_receipt_id
    ,lir.location_item_receipt_pos_id
) AS lir

/* Auflösung WH */
INNER JOIN P_LEW_CORE_AC.v_location AS loc_wh
ON lir.client_id = loc_wh.client_id
  AND lir.loc_sid_wh = loc_wh.loc_sid
  AND Upper(loc_wh.wh_store_mark) = 'B' /* WHs */

/* Währung bestimmen */
INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist AS erkh
ON lir.client_id = erkh.client_id
  AND Current_Date BETWEEN erkh.active_from_dt AND erkh.active_to_dt
  AND Current_Date BETWEEN erkh.dwh_valid_from AND erkh.dwh_valid_to

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type AS ert
ON erkh.client_id = ert.client_id
  AND erkh.x_rate_type_sid = ert.x_rate_type_sid
  AND ert.src_kurst = '@BEWE'

/* Generiere DMY receipt_type_ids */
CROSS JOIN
(
  SELECT receipt_type_id FROM (SELECT CAST(1 AS INTEGER) AS receipt_type_id) AS eins
  UNION ALL
  SELECT receipt_type_id FROM (SELECT CAST(4 AS INTEGER) AS receipt_type_id) AS vier
  UNION ALL
  SELECT receipt_type_id FROM (SELECT CAST(5 AS INTEGER) AS receipt_type_id) AS fuenf
) AS dmy_receipt_type_ids

/* Internationale Itemgroup bestimmen */
LEFT OUTER JOIN P_LEW_BIL_AC.v_itemgroup_international AS itin
ON lir.client_id = itin.client_id
  AND lir.item_grp_int_sid_asis = itin.item_grp_int_sid
;

