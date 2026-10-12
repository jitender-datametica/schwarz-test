/* DescStart
$Revision: 13364 $, $LastChangedBy: umeister $
SubjectAreas: Anliefermenge
DescEnd */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat0_wawi_mov_item_delivery_2 AS -- a.dat_formdate/100+190000 AS cy_month,
 SELECT
 a.client_id,
 a.item_sid,
 a.dat_formdate,
 a.st_loc_sid AS loc_sid_store,
 ST2W.loc_sid_wh,
 a.deliverytype_id,
 P.src_orig_store_nr AS orig_store_nr,
 FORMAT_DATE('%Y%m', DATE(a.dat_formdate)) AS cy_month,
 N.sub_item_grp_sid,
  CASE
  WHEN R.item_sid IS NOT NULL
  THEN 1
  ELSE 0
  END AS foodaction_fg,
 ROUND(CAST((IFNULL(a.qty_case_del, 0) + IFNULL(a.qty_case_order, 0)) * COALESCE(a.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)) + IFNULL(a.qty_piece_del, 0) AS NUMERIC)
  , 4) AS qty_total_del,
 ROUND(CAST(IFNULL(a.price_str_del, 0) * ((IFNULL(a.qty_case_del, 0) + IFNULL(a.qty_case_order, 0)) * COALESCE(a.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)
        ) + IFNULL(a.qty_piece_del, 0)) AS NUMERIC), 4) AS val_rtl_rl_del,
 ROUND(CAST(IFNULL(a.price_str_net_del, 0) * ((IFNULL(a.qty_case_del, 0) + IFNULL(a.qty_case_order, 0)) * COALESCE(a.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)
        ) + IFNULL(a.qty_piece_del, 0)) AS NUMERIC), 5) AS val_rtl_rl_net_del,
 ROUND(CAST(IFNULL(a.qty_case_del, 0) * COALESCE(a.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)) + IFNULL(a.qty_piece_del
     , 0) AS NUMERIC), 4) AS qty_piece_del_agg,
 ROUND(CAST(IFNULL(a.price_str_del, 0) * (IFNULL(a.qty_case_del, 0) * COALESCE(a.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)
        ) + IFNULL(a.qty_piece_del, 0)) AS NUMERIC), 4) AS val_piece_del,
 ROUND(CAST(IFNULL(a.price_str_net_del, 0) * (IFNULL(a.qty_case_del, 0) * COALESCE(a.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)
        ) + IFNULL(a.qty_piece_del, 0)) AS NUMERIC), 5) AS val_piece_net_del,
  ROUND(CAST(IFNULL(a.price_str_del, 0) - IFNULL(a.price_wh_del, 0) AS NUMERIC), 4) * ROUND(CAST((IFNULL(a.qty_case_del, 0) + IFNULL(a.qty_case_order, 0)) * COALESCE(a.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)
       ) + IFNULL(a.qty_piece_del, 0) AS NUMERIC), 4) AS val_pr_diff_del,
  CAST(IFNULL(a.price_str_net_del, 0) - IFNULL(a.price_wh_net_del, 0) AS NUMERIC) * ROUND(CAST((IFNULL(a.qty_case_del, 0) + IFNULL(a.qty_case_order, 0)) * COALESCE(a.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)
       ) + IFNULL(a.qty_piece_del, 0) AS NUMERIC), 5) AS val_pr_diff_net_del,
 0 AS src_fg
FROM (SELECT client_id,
   loc_sid_store AS st_loc_sid,
   item_sid,
   delivery_type_id AS deliverytype_id,
   wh_del_gross_price AS price_wh_del,
   wh_del_net_price AS price_wh_net_del,
   store_del_gross_price AS price_str_del,
   store_del_net_price AS price_str_net_del,
   del_case_qty AS qty_case_del,
   ordered_case_qty AS qty_case_order,
   del_piece_qty AS qty_piece_del,
   case_size_dec,
   dwh_cal_dt AS dat_formdate
  FROM ldl_p_lew_core_ac.v_item_delivery_2) AS a
 INNER JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown_2 AS ST2W ON a.client_id = ST2W.client_id AND a.st_loc_sid = ST2W
   .loc_sid_store
 INNER JOIN ldl_p_lew_core_ac.v_item_2 AS F ON a.client_id = F.client_id AND a.item_sid = F.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS K ON F.client_id = K.client_id AND F.item_sid = K.item_sid AND CURRENT_DATE
   BETWEEN K.dwh_valid_from AND K.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_2 AS N ON K.client_id = N.client_id AND K.item_fam_grp_sid = N.item_fam_grp_sid
     AND CURRENT_DATE BETWEEN N.dwh_valid_from AND N.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS P ON a.client_id = P.client_id AND a.st_loc_sid = P.loc_sid
 LEFT JOIN ldl_p_lew_bil.v_item_foodaction_hist_2 AS R ON a.client_id = R.client_id AND a.item_sid = R.item_sid AND a.dat_formdate
   BETWEEN R.dwh_valid_from AND R.dwh_valid_to;