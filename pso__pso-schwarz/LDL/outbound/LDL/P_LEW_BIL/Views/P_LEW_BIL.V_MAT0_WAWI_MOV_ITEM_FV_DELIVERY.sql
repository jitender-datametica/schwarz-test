/* DescStart
$Revision: 13734 $, $LastChangedBy: mueding $
SubjectAreas: Anliefermenge
DescEnd */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat0_wawi_mov_item_fv_delivery AS -- a.dwh_cal_dt/100+190000 AS cy_month,
 SELECT
 A.client_id,
 A.item_sid,
 A.dwh_cal_dt AS dat_formdate,
 A.loc_sid_store,
 ST2W.loc_sid_wh,
 4 AS deliverytype_id,
 P.src_orig_store_nr AS orig_store_nr,
 FORMAT_DATE('%Y%m', DATE(A.dwh_cal_dt)) AS cy_month,
 N.sub_item_grp_sid,
  CASE
  WHEN R.item_sid IS NOT NULL
  THEN 1
  ELSE 0
  END AS foodaction_fg,
 ROUND(CAST(IFNULL(A.case_qty * A.case_size_dec, 0) AS NUMERIC), 4) AS qty_total_del,
 ROUND(CAST(IFNULL(A.store_gross_price, 0) * IFNULL(ROUND(CAST(A.case_qty * A.case_size_dec AS NUMERIC), 4), 0) AS
   NUMERIC), 4) AS val_rtl_rl_del,
 ROUND(CAST(IFNULL(A.store_net_price, 0) * IFNULL(ROUND(CAST(A.case_qty * A.case_size_dec AS NUMERIC), 5), 0) AS NUMERIC
   ), 5) AS val_rtl_rl_net_del,
 ROUND(CAST(IFNULL(A.case_qty * A.case_size_dec, 0) AS NUMERIC), 4) AS qty_piece_del_agg,
 ROUND(CAST(IFNULL(A.store_gross_price, 0) * IFNULL(ROUND(CAST(A.case_qty * A.case_size_dec AS NUMERIC), 4), 0) AS
   NUMERIC), 4) AS val_piece_del,
 ROUND(CAST(IFNULL(A.store_net_price, 0) * IFNULL(ROUND(CAST(A.case_qty * A.case_size_dec AS NUMERIC), 5), 0) AS NUMERIC
   ), 5) AS val_piece_net_del,
  ROUND(CAST(IFNULL(A.store_gross_price, 0) - IFNULL(A.wh_gross_price, 0) AS NUMERIC), 4) * IFNULL(ROUND(CAST(IFNULL(A.case_qty * A.case_size_dec, 0) AS NUMERIC)
    , 4), 0) AS val_pr_diff_del,
  CAST(IFNULL(A.store_net_price, 0) - IFNULL(A.wh_net_price, 0) AS NUMERIC) * IFNULL(ROUND(CAST(IFNULL(A.case_qty * A.case_size_dec, 0) AS NUMERIC)
    , 5), 0) AS val_pr_diff_net_del,
 0 AS src_fg
FROM ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery AS A
 INNER JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown AS ST2W ON A.client_id = ST2W.client_id AND A.loc_sid_store =
   ST2W.loc_sid_store
 INNER JOIN ldl_p_lew_core_ac.v_item AS F ON A.client_id = F.client_id AND A.item_sid = F.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_hist AS K ON F.client_id = K.client_id AND F.item_sid = K.item_sid AND CURRENT_DATE
   BETWEEN K.dwh_valid_from AND K.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS N ON K.client_id = N.client_id AND K.item_fam_grp_sid = N.item_fam_grp_sid
     AND CURRENT_DATE BETWEEN N.dwh_valid_from AND N.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_location AS P ON A.client_id = P.client_id AND A.loc_sid_store = P.loc_sid
 LEFT JOIN ldl_p_lew_bil.v_item_foodaction_hist AS R ON A.client_id = R.client_id AND A.item_sid = R.item_sid AND A.dwh_cal_dt
   BETWEEN R.dwh_valid_from AND R.dwh_valid_to;


/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_bil_ac.v_agg_pos_store_item_day", "p_lew_core_ac.v_item_map_key", "p_lew_bil_ac.v_item", "p_lew_bil_ac.v_store", "p_lew_process_ac.v_wfm_export_agg_delta", "p_lew_core_ac.v_txj_520" ****/