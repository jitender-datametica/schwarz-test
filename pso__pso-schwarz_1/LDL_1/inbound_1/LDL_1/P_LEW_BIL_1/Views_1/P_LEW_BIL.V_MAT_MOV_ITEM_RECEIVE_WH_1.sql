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
#  2.9  14.11.2023    Torsten Bachmann     To save resources it was decided to exclude eLwis data from this view, because it won't change anymore.
#                                          So, there is no need to recalculate this data every day.
#----------------------------------------------------------------------------
*/



/*
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_MOV_ITEM_RECEIVE_WH_1
COMMENT = '$Revision: 16839 $ '

AS
/* WAWI-Daten */
SELECT
   rcv.client_id
  ,rcv.wh_loc_sid AS loc_sid_wh
  ,loc_wh.src_wh_id
  ,rcv.item_sid
  ,rcv.dat_formdate AS dwh_cal_dt
  ,rcv.customer_nr
  ,rcv.receipt_id_rcv AS location_item_receipt_id
  ,rcv.receipt_pos_nr_rcv AS location_item_receipt_pos_id
  ,rcv.receipttype_id AS receipt_type_id
  ,rcv.currency_id
  ,rcv.dat_dayend
  ,rcv.dat_entry_rcv AS entry_dt
  ,rcv.dat_adjustment_rcv
  ,rcv.dat_min_durability_rcv
  ,rcv.dat_valid_from
  ,rcv.dat_valid_until
  ,rcv.sup_sid
  ,rcv.sup_sid_pay
  ,rcv.mapping_pos_nr
  ,rcv.orig_receipt_id_rcv
  ,rcv.receipt_pos_partdel_fg
  ,rcv.receipt_pos_matchable_rel_fg
  ,rcv.receipt_pos_margin_rel_fg
  ,rcv.status_tg
  ,rcv.vat_id
  ,rcv.pct_vat_rcv
  ,rcv.item_category_id
  ,rcv.stock_location_nr
  ,rcv.qty_case_rcv AS receive_case_qty
  ,rcv.qty_piece_rcv
  ,rcv.qty_total_rcv AS receive_piece_qty
  ,rcv.price_buying_rcv / erkh.exchange_rate AS price_buying_rcv
  ,rcv.price_buying_euro_rcv
  ,rcv.price_retail_rcv / erkh.exchange_rate AS price_retail_rcv
  ,rcv.price_retail_net_rcv /erkh.exchange_rate AS price_retail_net_rcv
  ,rcv.val_buying_rcv / erkh.exchange_rate AS buying_val
  ,rcv.val_buying_sup_rcv AS val_buying_suppl_rcv
  ,rcv.val_buying_euro AS val_buying_euro
  ,rcv.val_retail_rcv / erkh.exchange_rate AS retail_val
  ,rcv.val_net_retail_rcv / erkh.exchange_rate AS retail_net_val
  ,rcv.val_deposit_rcv / erkh.exchange_rate AS val_deposit_rcv
  ,rcv.case_size_dec
  ,rcv.package_qty
  ,CASE
     WHEN fa.client_id IS NOT NULL
     THEN rcv.val_buying_rcv / erkh.exchange_rate
     ELSE NULL
   END AS buying_fa_val
  ,CASE
     WHEN fa.client_id IS NOT NULL
     THEN rcv.val_net_retail_rcv / erkh.exchange_rate
     ELSE NULL
   END AS retail_net_fa_val
  ,erkh.curr_cd_from
FROM P_LEW_CORE_AC.v_wawi_mov_item_wh_receiving_1 AS rcv

INNER JOIN P_LEW_CORE_AC.v_client_migration_per_1 m
ON rcv.client_id = m.client_id
  AND
  (
    rcv.dat_entry_rcv < m.migration_dat_valid_from  /* Wawi Laender */
    OR rcv.dat_entry_rcv > m.migration_dat_valid_to /* eLWIS rollback Laender */
  )

/* Auflösung WH */
INNER JOIN P_LEW_CORE_AC.v_location_1 AS loc_wh
ON rcv.client_id = loc_wh.client_id
  AND rcv.wh_loc_sid = loc_wh.loc_sid
  AND Upper(loc_wh.wh_store_mark) = 'B' /* WHs */

/* Währung bestimmen */
INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist_1 AS erkh
ON rcv.client_id = erkh.client_id
  AND Current_Date BETWEEN erkh.active_from_dt AND erkh.active_to_dt
  AND Current_Date BETWEEN erkh.dwh_valid_from AND erkh.dwh_valid_to

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type_1 AS ert
ON erkh.client_id = ert.client_id
  AND erkh.x_rate_type_sid = ert.x_rate_type_sid
  AND ert.src_kurst = '@BEWE'

/* Foodaction ermitteln */
LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_item_foodaction_asws_act_1 AS fa
ON  rcv.client_id = fa.client_id
  AND rcv.item_sid = fa.item_sid
  AND rcv.dat_entry_rcv = fa.dat_valid

/* Nur Daten der letzten 40 Monate anzeigen */
WHERE rcv.dat_entry_rcv > ADD_MONTHS(Current_Date, -40)

  /*Sonderbehandlung aufgrund Abbrueche im Mai 2018 HU (EAN_1 im Preis...)*/
  AND TRY_CAST(CAST(COALESCE(rcv.price_buying_rcv, 0) AS VARCHAR(50)) AS DECIMAL(18,5)) IS NOT NULL
  AND TRY_CAST(CAST(COALESCE(rcv.price_buying_euro_rcv, 0) AS VARCHAR(50)) AS DECIMAL(18,5)) IS NOT NULL
  AND TRY_CAST(CAST(COALESCE(rcv.price_retail_rcv, 0) AS VARCHAR(50)) AS DECIMAL(18,5)) IS NOT NULL
  AND TRY_CAST(CAST(COALESCE(rcv.price_retail_net_rcv, 0) AS VARCHAR(50)) AS DECIMAL(18,5)) IS NOT NULL
  AND TRY_CAST(CAST(COALESCE(rcv.val_buying_rcv, 0) AS VARCHAR(50)) AS DECIMAL(18,5)) IS NOT NULL
  AND TRY_CAST(CAST(COALESCE(rcv.val_buying_sup_rcv, 0) AS VARCHAR(50)) AS DECIMAL(18,5)) IS NOT NULL
  AND TRY_CAST(CAST(COALESCE(rcv.val_buying_euro, 0) AS VARCHAR(50)) AS DECIMAL(18,5)) IS NOT NULL
  AND TRY_CAST(CAST(COALESCE(rcv.val_retail_rcv, 0) AS VARCHAR(50)) AS DECIMAL(18,5)) IS NOT NULL
  AND TRY_CAST(CAST(COALESCE(rcv.val_net_retail_rcv, 0) AS VARCHAR(50)) AS DECIMAL(18,5)) IS NOT NULL
  AND TRY_CAST(CAST(COALESCE(rcv.val_deposit_rcv, 0) AS VARCHAR(50)) AS DECIMAL(18,5)) IS NOT NULL
;

