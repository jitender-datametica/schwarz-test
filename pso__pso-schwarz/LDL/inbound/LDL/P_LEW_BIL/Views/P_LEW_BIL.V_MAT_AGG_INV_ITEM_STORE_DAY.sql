/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_MAT_AGG_INV_ITEM_STORE_DAY
#----------------------------------------------------------------------------
# History:
#  1.0  06.12.2017    Patrick Mittler       Change name of Object (itm to item) and
#  1.1  28.02.2018    Taubkin, Slavik       Umstellung auf last_known Views
#  1.2  02.03.2018    Meister,Ulrich        Spaltenkommentare wieder hinzugefuegt
#  1.3  24.04.2018    Mittler,Patrick       Filter auf Exraktor MM hinzugefuegt
#  1.4  28.01.2019    Michael Beerweiler    20190122_1929_InvDiffFiliale_neuer_Extraktor_Views
#                                           Umstellung auf neuen Extraktor/neue Core-Tabelle
#  1.5  09.10.2019    Patrick Barczak       Bugfix bei mov_type_cd filter, Umstellung auf string von int
#  1.6  09.10.2019    Harald Wieber         Code Review Anpassungen
#  1.7  19.02.2021    Prasanna Ranjan       REP2-9080 - Include item types ZKM and ZVM from USA and Serbia
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_AGG_INV_ITEM_STORE_DAY COMMENT = 'View'
(
  client_id                     COMMENT ''
, loc_sid_store                 COMMENT ''
, src_orig_store_nr             COMMENT ''
, src_wh_id                     COMMENT ''
, item_sid                      COMMENT ''
, dwh_cal_dt                    COMMENT ''
, cy_month                      COMMENT ''
, inv_diff_total_piece          COMMENT ''
, inv_diff_total_val            COMMENT ''
, inv_diff_total_net_val        COMMENT ''
/*Inventurdifferenz Type A Vollinventuren*/
, inv_diff_type_a_piece         COMMENT ''
, inv_diff_type_a_val           COMMENT ''
, inv_diff_type_a_net_val       COMMENT ''
/* Inventurdifferenz Type B Teilinventuren*/
, inv_diff_type_b_piece         COMMENT ''
, inv_diff_type_b_val           COMMENT ''
, inv_diff_type_b_net_val       COMMENT ''
/* Inventurdifferenz Type C Gesellschaftsinitiierte Einzelinventur*/
, inv_diff_type_c_piece         COMMENT ''
, inv_diff_type_c_val           COMMENT ''
, inv_diff_type_c_net_val       COMMENT ''
/* Inventurdifferenz Type D Filialinitiierte Einzelinventur*/
, inv_diff_type_d_piece         COMMENT ''
, inv_diff_type_d_val           COMMENT ''
, inv_diff_type_d_net_val       COMMENT ''
/* Inventurdifferenz Type <> A,B,C,D*/
, inv_diff_type_oth_piece       COMMENT ''
, inv_diff_type_oth_val         COMMENT ''
, inv_diff_type_oth_net_val     COMMENT ''
)

AS

SELECT
  inv.client_id
, lc_str.loc_sid_store
, lc_str.src_orig_store_nr
, org_wh.src_wh_id
, inv.item_sid
, inv.dwh_cal_dt
, to_number(to_char(inv.dwh_cal_dt,'YYYYMM'))      AS cy_month
, SUM(COALESCE(inv.inv_diff_qty,0))                AS inv_diff_total_piece
, SUM(COALESCE(inv.inv_diff_gross_val,0))          AS inv_diff_total_val
, SUM(COALESCE(inv.inv_diff_net_val,0))            AS inv_diff_total_net_val
/*Inventurdifferenz Type A Vollinventuren*/
, Sum(CASE WHEN inv.inv_type_cd = 'A'
           THEN COALESCE(inv.inv_diff_qty,0)
           ELSE 0 END)                             AS inv_diff_type_a_piece
, Sum(CASE WHEN inv.inv_type_cd = 'A'
           THEN COALESCE(inv.inv_diff_gross_val,0)
           ELSE 0 END)                             AS inv_diff_type_a_val
, Sum(CASE WHEN inv.inv_type_cd = 'A'
           THEN COALESCE(inv.inv_diff_net_val,0)
           ELSE 0 END)                             AS inv_diff_type_a_net_val
/* Inventurdifferenz Type B Teilinventuren*/
, Sum(CASE WHEN inv.inv_type_cd = 'B'
           THEN COALESCE(inv.inv_diff_qty,0)
           ELSE 0 END)                             AS inv_diff_type_b_piece
, Sum(CASE WHEN inv.inv_type_cd = 'B'
           THEN COALESCE(inv.inv_diff_gross_val,0)
           ELSE 0 END)                             AS inv_diff_type_b_val
, Sum(CASE WHEN inv.inv_type_cd = 'B'
           THEN COALESCE(inv.inv_diff_net_val,0)
           ELSE 0 END)                             AS inv_diff_type_b_net_val
/* Inventurdifferenz Type C Gesellschaftsinitiierte Einzelinventur*/
, Sum(CASE WHEN inv.inv_type_cd = 'C'
           THEN COALESCE(inv.inv_diff_qty,0)
           ELSE 0 END)                             AS inv_diff_type_c_piece
, Sum(CASE WHEN inv.inv_type_cd = 'C'
           THEN COALESCE(inv.inv_diff_gross_val,0)
           ELSE 0 END)                             AS inv_diff_type_c_val
, Sum(CASE WHEN inv.inv_type_cd = 'C'
           THEN COALESCE(inv.inv_diff_net_val,0)
           ELSE 0 END)                             AS inv_diff_type_c_net_val
/* Inventurdifferenz Type D Filialinitiierte Einzelinventur*/
, Sum(CASE WHEN inv.inv_type_cd = 'D'
           THEN COALESCE(inv.inv_diff_qty,0)
           ELSE 0 END)                             AS inv_diff_type_d_piece
, Sum(CASE WHEN inv.inv_type_cd = 'D'
           THEN COALESCE(inv.inv_diff_gross_val,0)
           ELSE 0 END)                             AS inv_diff_type_d_val
, Sum(CASE WHEN inv.inv_type_cd = 'D'
           THEN COALESCE(inv.inv_diff_net_val,0)
           ELSE 0 END)                             AS inv_diff_type_d_net_val
/* Inventurdifferenz Type <> A,B,C,D*/
, Sum(CASE WHEN inv.inv_type_cd IS NULL OR inv.inv_type_cd NOT IN ('A', 'B', 'C', 'D')
           THEN COALESCE(inv.inv_diff_qty,0)
           ELSE 0 END)                             AS inv_diff_type_oth_piece
, Sum(CASE WHEN inv.inv_type_cd IS NULL OR inv.inv_type_cd NOT IN ('A', 'B', 'C', 'D')
           THEN COALESCE(inv.inv_diff_gross_val,0)
           ELSE 0 END)                             AS inv_diff_type_oth_val
, Sum(CASE WHEN inv.inv_type_cd IS NULL OR inv.inv_type_cd NOT IN ('A', 'B', 'C', 'D')
           THEN COALESCE(inv.inv_diff_net_val,0)
          ELSE 0 END)                             AS inv_diff_type_oth_net_val
FROM P_LEW_CORE_AC.v_inv_diff_record_pos AS inv

/* Zordnung der Filialen */
INNER JOIN P_LEW_BIL.v_store AS lc_str
    ON inv.client_id = lc_str.client_id
    AND inv.loc_sid = lc_str.loc_sid_store
    AND lc_str.dwh_actual_fg = 1        /* Aktueller Datensatz*/
    AND lc_str.test_store_fg = 0          /* Keine Testfiliale*/
    AND lc_str.pseudo_store_fg = 0

/* Zuordnung der Hauptlieferwerkbeziehungen Filiale zu Lager
 * Aktuell gueltige, zuletzt gueltige sowie zukuenftig gueltige Hauptlieferantenbeziehungen */
INNER JOIN P_LEW_BIL.v_store_to_warehouse_lastknown AS s_to_wh
    ON inv.client_id = s_to_wh.client_id
    AND inv.loc_sid = s_to_wh.loc_sid_store

/* Es werden auf die echten Lager eingeschraenkt */
INNER JOIN P_LEW_BIL.v_warehouse org_wh
    ON s_to_wh.client_id = org_wh.client_id
    AND s_to_wh.loc_sid_wh = org_wh.loc_sid_wh
    AND org_wh.dwh_actual_fg = 1
    AND org_wh.active_fg = 1
    AND org_wh.bges_active_fg = 1

/* Zuordnung der v_item_hist zu v_item_type, um die Artikelarten e.src_mtart heranzuziehen.
Die Artikelarten sind relevant fuer Filterkriterien*/
INNER JOIN P_LEW_CORE_AC.v_item_hist AS d
  ON inv.client_id = d.client_id
  AND inv.item_sid = d.item_sid
  AND CURRENT_DATE BETWEEN d.dwh_valid_from AND d.dwh_valid_to
  AND d.deleted_fg = 0

/* src_mtart zum Filtern von bestimmten Artikelarten herangezogen fuer die Umsaetze*/
LEFT OUTER JOIN P_LEW_CORE_AC.v_item_type AS e
  ON e.client_id = d.client_id
  AND e.item_type_sid = d.item_type_sid

/* Artikel die zu ignorieren sind  */
LEFT OUTER JOIN P_LEW_PROCESS_AC.v_item_type_ignore AS ig
  ON ig.client_id = d.client_id
  AND ig.item_type_cd = e.src_mtart
  AND 
    (
      (
       ig.client_id IN (33, 34) 
       AND ig.item_type_cd  NOT IN ('ZKM', 'ZVM')
      )
      OR ig.client_id NOT IN (33, 34)
    ) 
  AND ig.item_type_grp_cd IN ('BAGLEVY', 'INV')
/* Filter auf Store nicht relevant, da die View v_store Stammdatenview/tabelle
und die Zuordnung der Hauptlieferwerkbeziehungen zu den Stores herangezogen wurden*/
/*Ungefilterte Artikelarten*/
WHERE ig.item_type_cd IS NULL
/* Nur die Bewegungsarten, welche Inventuren betreffen oder NULL */
AND (inv.move_type_cd IN ('701', '702', '703', '704', '707', '708', '711', '712', '717', '718') OR inv.move_type_cd IS NULL)
GROUP BY 1,2,3,4,5,6,7
;