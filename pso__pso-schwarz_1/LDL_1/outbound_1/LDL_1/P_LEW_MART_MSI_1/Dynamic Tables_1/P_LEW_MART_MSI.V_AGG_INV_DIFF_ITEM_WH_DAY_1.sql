
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_agg_inv_diff_item_wh_day_1
 AS
/* Die Daten aus dem SAP MM_1, WM_1 und EWM kommen alle aus der Tabelle t_inv_diff_record_pos_1 */
/* only takes the warehouse records from t_inv_diff_record_pos_1 */ /* Der fachlische WH-Schluessel wird herangezogen */
/* Durch dAS joinen der v_org_wh_1 werden die in v_warehouse_1 fehlende Lager ergaenzt. */ /* Ungefilterte Artikelarten */
SELECT inv.client_id,
 inv.loc_sid,
 wh.wh_id,
 inv.item_sid AS item_id,
 inv.dwh_cal_dt AS dat_formdate,
 SUM(COALESCE(inv.inv_diff_qty, 0)) AS inv_diff_total_piece,
 SUM(COALESCE(inv.inv_diff_gross_val, 0)) AS inv_diff_total_val,
 SUM(COALESCE(inv.inv_diff_net_val, 0)) AS inv_diff_total_net_val,
 SUM(CASE
   WHEN inv.inv_type_cd = 'A'
   THEN COALESCE(inv.inv_diff_qty, 0)
   ELSE 0
   END) AS inv_diff_type_a_piece,
 SUM(CASE
   WHEN inv.inv_type_cd = 'A'
   THEN COALESCE(inv.inv_diff_gross_val, 0)
   ELSE 0
   END) AS inv_diff_type_a_val,
 SUM(CASE
   WHEN inv.inv_type_cd = 'A'
   THEN COALESCE(inv.inv_diff_net_val, 0)
   ELSE 0
   END) AS inv_diff_type_a_net_val,
 SUM(CASE
   WHEN inv.inv_type_cd = 'B'
   THEN COALESCE(inv.inv_diff_qty, 0)
   ELSE 0
   END) AS inv_diff_type_b_piece,
 SUM(CASE
   WHEN inv.inv_type_cd = 'B'
   THEN COALESCE(inv.inv_diff_gross_val, 0)
   ELSE 0
   END) AS inv_diff_type_b_val,
 SUM(CASE
   WHEN inv.inv_type_cd = 'B'
   THEN COALESCE(inv.inv_diff_net_val, 0)
   ELSE 0
   END) AS inv_diff_type_b_net_val,
 SUM(CASE
   WHEN inv.inv_type_cd = 'X'
   THEN COALESCE(inv.inv_diff_qty, 0)
   ELSE 0
   END) AS inv_diff_type_x_piece,
 SUM(CASE
   WHEN inv.inv_type_cd = 'X'
   THEN COALESCE(inv.inv_diff_gross_val, 0)
   ELSE 0
   END) AS inv_diff_type_x_val,
 SUM(CASE
   WHEN inv.inv_type_cd = 'X'
   THEN COALESCE(inv.inv_diff_net_val, 0)
   ELSE 0
   END) AS inv_diff_type_x_net_val,
 SUM(CASE
   WHEN inv.inv_type_cd IS NULL OR inv.inv_type_cd NOT IN ('A', 'B', 'X')
   THEN COALESCE(inv.inv_diff_qty, 0)
   ELSE 0
   END) AS inv_diff_type_oth_piece,
 SUM(CASE
   WHEN inv.inv_type_cd IS NULL OR inv.inv_type_cd NOT IN ('A', 'B', 'X')
   THEN COALESCE(inv.inv_diff_gross_val, 0)
   ELSE 0
   END) AS inv_diff_type_oth_val,
 SUM(CASE
   WHEN inv.inv_type_cd IS NULL OR inv.inv_type_cd NOT IN ('A', 'B', 'X')
   THEN COALESCE(inv.inv_diff_net_val, 0)
   ELSE 0
   END) AS inv_diff_type_oth_net_val
FROM (SELECT SI.client_id,
   SI.loc_sid,
   SI.item_sid,
   SI.dwh_cal_dt,
   SI.curr_sid,
   SI.inv_type_cd,
   SI.inv_diff_qty,
   SI.inv_diff_gross_val,
   SI.inv_diff_net_val
  FROM ldl_p_lew_core_ac.v_inv_diff_record_pos_1 AS SI
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS L ON SI.client_id = L.client_id AND SI.loc_sid = L.loc_sid_wh AND L.dwh_actual_fg
        = 1 AND L.active_fg = 1 AND L.bges_active_fg = 1
     /* Nur die Bewegungsarten, welche Inventuren betreffen oder NULL */
  WHERE CAST(SI.move_type_cd AS INTEGER) IN (701, 702, 703, 704, 707, 708, 711, 712, 717, 718)
   OR SI.move_type_cd IS NULL) AS inv
 INNER JOIN (SELECT L_WH.client_id,
   L_WH.dwh_valid_from,
   L_WH.dwh_valid_to,
   L_WH.loc_sid_wh,
   ORG_WH.wh_id
  FROM ldl_p_lew_bil_ac.v_warehouse_1 AS L_WH
   LEFT JOIN ldl_p_lew_mart_msi.v_org_wh_1 AS ORG_WH ON L_WH.client_id = ORG_WH.client_id AND L_WH.src_wh_id = ORG_WH.wh_id
     
  WHERE L_WH.dwh_actual_fg = 1
   AND L_WH.active_fg = 1
   AND L_WH.bges_active_fg = 1
   AND ORG_WH.wh_id IS NOT NULL) AS wh ON inv.client_id = wh.client_id AND inv.loc_sid = wh.loc_sid_wh
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS D ON inv.client_id = D.client_id AND inv.item_sid = D.item_sid AND D.deleted_fg
     = 0 AND CURRENT_DATE BETWEEN D.dwh_valid_from AND D.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_item_type_1 AS ITM ON D.client_id = ITM.client_id AND D.item_type_sid
   /* Artikel_1 die zu ignorieren sind, die der Artikelgruppe Baglevy und INV zugewiesen sind */ = ITM.item_type_sid
 LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_1 AS IG ON D.client_id = IG.client_id AND ITM.src_mtart = IG.item_type_cd
      AND (IG.client_id IN (33, 34) AND IG.item_type_cd NOT IN ('ZKM', 'ZVM') OR IG.client_id NOT IN (33, 34)) AND IG.item_type_grp_cd
    IN ('BAGLEVY', 'INV')
WHERE IG.item_type_cd IS NULL
GROUP BY inv.client_id,
 inv.loc_sid,
 wh.wh_id,
 item_id,
 dat_formdate;
