/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_MAT0_DELIV_BASE_CORE
#----------------------------------------------------------------------------
# History:
#  1.0  17.01.2018    Wieber.Harald            Update Release 2.2
#  1.0  02.03.2018    Michael Ueding           Logik aus mat_deliv_base_core
#  1.2  19.03.2018    Martin Murtenthaler      Comment von column src_fg geaendert
#  1.3  26.03.2018    Martin Murtenthaler      Columns WH_ID and Subitemgroup changed
#  1.4  04.04.2018    Arnold.Arne              X_LEW_BIL.V_STORE fuer Store-Informationen aufgenommen und WH Bestimmung auf Last-Known umgestellt.
#  1.5  06.04.2018    Martin Murtenthaler      ASIS-Sicht auch fuer Foodaction Flag
#  1.6  19.04.2018    Knopp.Timo               Modification of access to core table lew_core.t_map_mis_move_type / map_mis_move_type_deliv after renaming core-Table
#  1.7  19.04.2018    Knopp.Timo               Modification of access to core table lew_core.t_map_mis_move_type / map_mis_move_type_deliv after renaming core-Table
#  1.8  19.04.2018    Knopp.Timo               Modification of access to core table lew_core.t_map_mis_move_type / map_mis_move_type_deliv after renaming core-Table
#  1.9  19.04.2018    Knopp,Timo               Modification of access to core table lew_core.t_map_mis_move_type / map_mis_move_type_deliv after renaming core-Table
#  2.0  19.02.2021    Prasanna Ranjan          REP2-9080 - Include item types ZKM and ZVM from USA and Serbia
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat0_deliv_base_core (client_id OPTIONS(description='Landeskennzeichen'),
item_sid OPTIONS(description='Surrogate Key Item'), dat_formdate OPTIONS(description='Bezugsdatum'), loc_sid_store
OPTIONS(description='enthaelt surrogate Key des Stores'), loc_sid_wh
OPTIONS(description='dem Store zugeordnetes Warehouse'), deliverytype_id
OPTIONS(description='Konstanten: 1 = Zuteilungen / 2 = Kommisionierlisten / 3 = Direktlieverungen / 4 = FV / DEL 1 oder 2 / DIR 3 / FV 4 / CORE 1, 2 oder 3'),
orig_store_nr OPTIONS(description='WAWI Quellsystemschluessel'), cy_month
OPTIONS(description='Monat des Geschaeftsjahres im Format "JJJJMM"'), sub_item_grp_sid
OPTIONS(description='Subitemgroup'), foodaction_fg OPTIONS(description='Foodactionflag'), qty_total_del
OPTIONS(description='DEL (qty_case_del + qty_case_order) * COALESCE(case_size_dec, case_size) + qty_piece_del / DIR qty_case_del * COALESCE(case_size_dec, case_size) + qty_piece_del / FV qty_case_del * case_size_real / CORE MSEG.MENGE  * COALESCE(STPO.MENGE,1)'),
val_rtl_rl_del
OPTIONS(description='DEL price_str_del * qty_total_del / DIR price_wh_del * qty_total_del / FV price_str_del * qty_total_del / CORE COALESCE(Effektiver Bruttopreis Store * qty_total_del, 1)'),
val_rtl_rl_net_del
OPTIONS(description='DEL price_str_net_del * qty_total_del / DIR price_wh_net_del * qty_total_del / FV price_str_net_del * qty_total_del / CORE COALESCE(Effektiver Nettopreis Store * qty_total_del, 1)'),
qty_piece_del_agg
OPTIONS(description='DEL qty_case_del * COALESCE(case_size_dec, case_size) + qty_piece_del / DIR qty_total_del / FV qty_total_del / CORE immer 0'),
val_piece_del
OPTIONS(description='DEL price_str_del * qty_piece_del_agg / DIR price_wh_del * qty_piece_del_agg / FV price_str_del * qty_piece_del_agg / CORE immer 0'),
val_piece_net_del
OPTIONS(description='DEL price_str_net_del * qty_piece_del_agg / DIR price_wh_net_del * qty_piece_del_agg / FV price_str_net_del * qty_piece_del_agg / CORE immer 0'),
val_pr_diff_del
OPTIONS(description='DEL / DIR / FV (price_str_del - price_wh_del) * qty_total_del / CORE (Effektiver Bruttopreis Store - Effektiver Bruttopreis Warehouse) * qty_total_del'),
val_pr_diff_net_del
OPTIONS(description='DEL / DIR / FV (price_str_net_del - price_wh_net_del) * qty_total_del / CORE (Effektiver Nettopreis Store - Effektiver Nettopreis Warehouse) * qty_total_del'),
src_fg OPTIONS(description='immer 1 bedeutend "aus SAP"'))
OPTIONS(DESCRIPTION = `LADEVIEW BASISTABELLE DELIVERY QUELLE DWH2.0 CORE`) AS
/* Auswertung 10er-Stelle (Resultat Division ist Integer ungerundet) */ /* Ungefilterte Artikelarten */ SELECT B.client_id
 ,
 COALESCE(C.item_sid, B.item_sid) AS item_sid,
 B.dwh_cal_dt AS dat_formdate,
 B.loc_sid AS loc_sid_store,
 ST2W.loc_sid_wh,
 Q.mis_deliv_type_id AS deliverytype_id,
 ST.src_orig_store_nr AS orig_store_nr,
 ROUND(CAST(FORMAT_DATE('%Y%m', B.dwh_cal_dt) AS BIGNUMERIC), 0) AS cy_month,
 N.sub_item_grp_sid,
  CASE
  WHEN R.item_sid IS NOT NULL
  THEN 1
  ELSE 0
  END AS foodaction_fg,
 ROUND(CAST(B.ship_qty * COALESCE(C.component_qty, 1) AS NUMERIC), 4) AS qty_total_del,
 ROUND(CAST(COALESCE(L.cond_val_eff_calc * ROUND(CAST(B.ship_qty * COALESCE(C.component_qty, 1) AS NUMERIC), 4), 1) AS
   NUMERIC), 4) AS val_rtl_rl_del,
 ROUND(CAST(COALESCE(L.net_val_eff_calc * ROUND(CAST(B.ship_qty * COALESCE(C.component_qty, 1) AS NUMERIC), 4), 1) AS
   NUMERIC), 5) AS val_rtl_rl_net_del,
 0 AS qty_piece_del_agg,
 0 AS val_piece_del,
 0 AS val_piece_net_del,
 CAST(NULL AS NUMERIC) AS val_pr_diff_del,
 CAST(NULL AS BIGNUMERIC) AS val_pr_diff_net_del,
 1 AS src_fg
FROM ldl_p_lew_core_ac.v_item_movement_record_pos AS B
 LEFT JOIN (SELECT CA.client_id,
   CA.item_sid,
   CA.item_bom_sid
  FROM ldl_p_lew_core_ac.v_item_bom AS CA
   LEFT JOIN ldl_p_lew_core_ac.v_item_bom AS CB ON CA.client_id = CB.client_id AND CA.item_sid = CB.item_sid AND CB.src_werks
        = '@ALL' AND CB.deleted_fg = 0 AND (CA.src_stlnr < CB.src_stlnr OR CA.src_stlnr = CB.src_stlnr AND CA.item_bom_sid
         < CB.item_bom_sid)
  WHERE CA.src_werks = '@ALL'
   AND CA.deleted_fg = 0
   AND CB.client_id IS NULL) AS c0 ON B.client_id = c0.client_id AND B.item_sid = c0.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_bom_pos_hist AS C ON c0.client_id = C.client_id AND c0.item_bom_sid = C.item_bom_sid
      AND CURRENT_DATE BETWEEN C.dwh_valid_from AND C.dwh_valid_to AND C.deleted_fg = 0 /* LKP WH */
 LEFT JOIN ldl_p_lew_core_ac.v_location AS F ON B.client_id = F.client_id AND B.loc_sid_counterparty = F.loc_sid AND F.wh_store_mark
    = 'B' /* Keine Teststores */
 INNER JOIN ldl_p_lew_bil.v_store AS ST ON B.client_id = ST.client_id AND B.loc_sid = ST.loc_sid_store AND ST.test_store_fg
     = 0 AND ST.dwh_actual_fg = 1 /* LKP letzte, bekannte WH-Zuordnung */
 INNER JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown AS ST2W ON B.client_id = ST2W.client_id AND B.loc_sid = ST2W.loc_sid_store
   
 INNER JOIN ldl_p_lew_core_ac.v_item_hist AS K ON B.client_id = K.client_id AND K.item_sid = COALESCE(C.item_sid, B.item_sid
     ) AND CURRENT_DATE BETWEEN K.dwh_valid_from AND K.dwh_valid_to
 LEFT JOIN ldl_p_lew_bil.v_item_loc_sales_cond_denorm AS L ON K.client_id = L.client_id AND K.item_sid = L.item_sid AND
     K.uom_sid_base = L.uom_sid_cond AND B.loc_sid = L.loc_sid AND B.dwh_cal_dt BETWEEN L.dwh_valid_from AND L.dwh_valid_to
   
 LEFT JOIN ldl_p_lew_bil.v_item_loc_sales_cond_denorm AS M ON K.client_id = M.client_id AND K.item_sid = M.item_sid AND
     K.uom_sid_base = M.uom_sid_cond AND ST2W.loc_sid_wh = M.loc_sid AND B.dwh_cal_dt BETWEEN M.dwh_valid_from AND M.dwh_valid_to
   
 LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS N ON K.client_id = N.client_id AND K.item_fam_grp_sid = N.item_fam_grp_sid
     AND CURRENT_DATE BETWEEN N.dwh_valid_from AND N.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_order_record AS P ON B.client_id = P.client_id AND B.order_record_id = P.order_record_id
   
 INNER JOIN ldl_p_lew_core_ac.v_map_mis_move_type_deliv AS Q ON P.client_id = Q.client_id AND P.order_type_cd = Q.order_type_cd
     AND B.move_type_cd = Q.move_type_cd
 LEFT JOIN ldl_p_lew_bil.v_item_foodaction_hist AS R ON K.client_id = R.client_id AND K.item_sid = R.item_sid AND
   CURRENT_DATE BETWEEN R.dwh_valid_from AND R.dwh_valid_to /* Zu ignorierende Artikelarten */
 LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore AS ITI ON K.client_id = ITI.client_id AND K.item_type_sid = ITI.item_type_sid
      AND (ITI.client_id IN (33, 34) AND ITI.item_type_cd NOT IN ('ZKM', 'ZVM') OR ITI.client_id NOT IN (33, 34)) AND
   ITI.item_type_grp_cd = 'ANL'
WHERE CASE
   WHEN Q.mis_deliv_type_id / 10 = 1 AND F.client_id IS NULL
   THEN 0
   ELSE 1
   END = 1
 AND ITI.item_type_cd IS NULL;