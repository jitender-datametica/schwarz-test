/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_MAT_AGG_INV_ITEM_STORE_DAY_2
#----------------------------------------------------------------------------
# History:
#  1.0  06.12.2017    Patrick Mittler       Change name of Object (itm to item_2) and
#  1.1  28.02.2018    Taubkin, Slavik       Umstellung auf last_known Views
#  1.2  02.03.2018    Meister,Ulrich        Spaltenkommentare wieder hinzugefuegt
#  1.3  24.04.2018    Mittler,Patrick       Filter auf Exraktor MM_2 hinzugefuegt
#  1.4  28.01.2019    Michael Beerweiler    20190122_1929_InvDiffFiliale_neuer_Extraktor_Views
#                                           Umstellung auf neuen Extraktor/neue Core-Tabelle
#  1.5  09.10.2019    Patrick Barczak       Bugfix bei mov_type_cd filter, Umstellung auf string von INTEGER 
#  1.6  09.10.2019    Harald Wieber         Code Review Anpassungen
#  1.7  19.02.2021    Prasanna Ranjan       REP2-9080 - Include item_2 types ZKM and ZVM from USA and Serbia
#----------------------------------------------------------------------------
*/


/* Inventurdifferenz Type C Gesellschaftsinitiierte Einzelinventur */ /* Inventurdifferenz Type A Vollinventuren */
/* Inventurdifferenz Type <> A,B,C,D */ /* Inventurdifferenz Type B Teilinventuren */
/* Inventurdifferenz Type D Filialinitiierte Einzelinventur */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_inv_item_store_day_2 (client_id OPTIONS(description=''), loc_sid_store
OPTIONS(description=''), src_orig_store_nr OPTIONS(description=''), src_wh_id OPTIONS(description=''), item_sid
OPTIONS(description=''), dwh_cal_dt OPTIONS(description=''), cy_month OPTIONS(description=''), inv_diff_total_piece
OPTIONS(description=''), inv_diff_total_val OPTIONS(description=''), inv_diff_total_net_val OPTIONS(description=''),
inv_diff_type_a_piece OPTIONS(description=''), inv_diff_type_a_val OPTIONS(description=''), inv_diff_type_a_net_val
OPTIONS(description=''), inv_diff_type_b_piece OPTIONS(description=''), inv_diff_type_b_val OPTIONS(description=''),
inv_diff_type_b_net_val OPTIONS(description=''), inv_diff_type_c_piece OPTIONS(description=''), inv_diff_type_c_val
OPTIONS(description=''), inv_diff_type_c_net_val OPTIONS(description=''), inv_diff_type_d_piece OPTIONS(description=''),
inv_diff_type_d_val OPTIONS(description=''), inv_diff_type_d_net_val OPTIONS(description=''), inv_diff_type_oth_piece
OPTIONS(description=''), inv_diff_type_oth_val OPTIONS(description=''), inv_diff_type_oth_net_val
OPTIONS(description='')) OPTIONS(DESCRIPTION = `VIEW`) AS /* Inventurdifferenz Type A Vollinventuren */
/* Inventurdifferenz Type B Teilinventuren */ /* Inventurdifferenz Type C Gesellschaftsinitiierte Einzelinventur */
/* Inventurdifferenz Type D Filialinitiierte Einzelinventur */ /* Inventurdifferenz Type <> A,B,C,D */
/* Zordnung der Filialen */ /* Nur die Bewegungsarten, welche Inventuren betreffen oder NULL */ SELECT INV.client_id,
 LC_STR.loc_sid_store,
 LC_STR.src_orig_store_nr,
 ORG_WH.src_wh_id,
 INV.item_sid,
 ROUND(CAST(FORMAT_DATE('%Y%m', INV.dwh_cal_dt) AS BIGNUMERIC), 0) AS dwh_cal_dt,
 ROUND(CAST(FORMAT_DATE('%Y%m', INV.dwh_cal_dt) AS BIGNUMERIC), 0) AS cy_month,
 SUM(COALESCE(INV.inv_diff_qty, 0)) AS inv_diff_total_piece,
 SUM(COALESCE(INV.inv_diff_gross_val, 0)) AS inv_diff_total_val,
 SUM(COALESCE(INV.inv_diff_net_val, 0)) AS inv_diff_total_net_val,
 SUM(CASE
   WHEN INV.inv_type_cd = 'A'
   THEN COALESCE(INV.inv_diff_qty, 0)
   ELSE 0
   END) AS inv_diff_type_a_piece,
 SUM(CASE
   WHEN INV.inv_type_cd = 'A'
   THEN COALESCE(INV.inv_diff_gross_val, 0)
   ELSE 0
   END) AS inv_diff_type_a_val,
 SUM(CASE
   WHEN INV.inv_type_cd = 'A'
   THEN COALESCE(INV.inv_diff_net_val, 0)
   ELSE 0
   END) AS inv_diff_type_a_net_val,
 SUM(CASE
   WHEN INV.inv_type_cd = 'B'
   THEN COALESCE(INV.inv_diff_qty, 0)
   ELSE 0
   END) AS inv_diff_type_b_piece,
 SUM(CASE
   WHEN INV.inv_type_cd = 'B'
   THEN COALESCE(INV.inv_diff_gross_val, 0)
   ELSE 0
   END) AS inv_diff_type_b_val,
 SUM(CASE
   WHEN INV.inv_type_cd = 'B'
   THEN COALESCE(INV.inv_diff_net_val, 0)
   ELSE 0
   END) AS inv_diff_type_b_net_val,
 SUM(CASE
   WHEN INV.inv_type_cd = 'C'
   THEN COALESCE(INV.inv_diff_qty, 0)
   ELSE 0
   END) AS inv_diff_type_c_piece,
 SUM(CASE
   WHEN INV.inv_type_cd = 'C'
   THEN COALESCE(INV.inv_diff_gross_val, 0)
   ELSE 0
   END) AS inv_diff_type_c_val,
 SUM(CASE
   WHEN INV.inv_type_cd = 'C'
   THEN COALESCE(INV.inv_diff_net_val, 0)
   ELSE 0
   END) AS inv_diff_type_c_net_val,
 SUM(CASE
   WHEN INV.inv_type_cd = 'D'
   THEN COALESCE(INV.inv_diff_qty, 0)
   ELSE 0
   END) AS inv_diff_type_d_piece,
 SUM(CASE
   WHEN INV.inv_type_cd = 'D'
   THEN COALESCE(INV.inv_diff_gross_val, 0)
   ELSE 0
   END) AS inv_diff_type_d_val,
 SUM(CASE
   WHEN INV.inv_type_cd = 'D'
   THEN COALESCE(INV.inv_diff_net_val, 0)
   ELSE 0
   END) AS inv_diff_type_d_net_val,
 SUM(CASE
   WHEN INV.inv_type_cd IS NULL OR INV.inv_type_cd NOT IN ('A', 'B', 'C', 'D')
   THEN COALESCE(INV.inv_diff_qty, 0)
   ELSE 0
   END) AS inv_diff_type_oth_piece,
 SUM(CASE
   WHEN INV.inv_type_cd IS NULL OR INV.inv_type_cd NOT IN ('A', 'B', 'C', 'D')
   THEN COALESCE(INV.inv_diff_gross_val, 0)
   ELSE 0
   END) AS inv_diff_type_oth_val,
 SUM(CASE
   WHEN INV.inv_type_cd IS NULL OR INV.inv_type_cd NOT IN ('A', 'B', 'C', 'D')
   THEN COALESCE(INV.inv_diff_net_val, 0)
   ELSE 0
   END) AS inv_diff_type_oth_net_val
FROM ldl_p_lew_core_ac.v_inv_diff_record_pos_2 AS INV
 INNER JOIN ldl_p_lew_bil.v_store_2 AS LC_STR ON INV.client_id = LC_STR.client_id AND INV.loc_sid = LC_STR.loc_sid_store
    AND LC_STR.dwh_actual_fg = 1 /* Aktueller Datensatz */ AND LC_STR.test_store_fg = 0 /* Keine Testfiliale */ AND
   LC_STR.pseudo_store_fg = 0
   /* Zuordnung der Hauptlieferwerkbeziehungen Filiale zu Lager
 * Aktuell gueltige, zuletzt gueltige sowie zukuenftig gueltige Hauptlieferantenbeziehungen */
   
 INNER JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown_2 AS S_TO_WH ON INV.client_id = S_TO_WH.client_id AND INV.loc_sid
    = S_TO_WH.loc_sid_store /* Es werden auf die echten Lager eingeschraenkt */
 INNER JOIN ldl_p_lew_bil.v_warehouse_2 AS ORG_WH ON S_TO_WH.client_id = ORG_WH.client_id AND S_TO_WH.loc_sid_wh = ORG_WH
      .loc_sid_wh AND ORG_WH.dwh_actual_fg = 1 AND ORG_WH.active_fg = 1 AND ORG_WH.bges_active_fg = 1
   /* Zuordnung der v_item_hist_2 zu v_item_type_2, um die Artikelarten e.src_mtart heranzuziehen.
Die Artikelarten sind relevant fuer Filterkriterien */
   
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS D ON INV.client_id = D.client_id AND INV.item_sid = D.item_sid AND
    CURRENT_DATE BETWEEN D.dwh_valid_from AND D.dwh_valid_to AND D.deleted_fg = 0
   /* src_mtart zum Filtern von bestimmten Artikelarten herangezogen fuer die Umsaetze */
 LEFT JOIN ldl_p_lew_core_ac.v_item_type_2 AS E ON D.client_id = E.client_id AND D.item_type_sid
   /* Artikel_2 die zu ignorieren sind */ = E.item_type_sid
 LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_2 AS IG ON D.client_id = IG.client_id AND E.src_mtart = IG.item_type_cd
      AND (IG.client_id IN (33, 34) AND IG.item_type_cd NOT IN ('ZKM', 'ZVM') OR IG.client_id NOT IN (33, 34)) AND IG.item_type_grp_cd
    IN ('BAGLEVY', 'INV')
  /* Filter auf Store nicht relevant, da die View v_store_2 Stammdatenview/tabelle
und die Zuordnung der Hauptlieferwerkbeziehungen zu den Stores herangezogen wurden */
  /* Ungefilterte Artikelarten */
WHERE IG.item_type_cd IS NULL
 AND (INV.move_type_cd IN ('701', '702', '703', '704', '707', '708', '711', '712', '717', '718') OR INV.move_type_cd
   IS NULL)
GROUP BY INV.client_id,
 LC_STR.loc_sid_store,
 LC_STR.src_orig_store_nr,
 ORG_WH.src_wh_id,
 INV.item_sid,
 INV.dwh_cal_dt,
 cy_month;