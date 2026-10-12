CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_QV_AGG_STORE_DAY_MISS_ITM_1
(
  client_id
, account_manager_id
, sales_manager_id
, move_to_store_id
, wh_id
, wh_id_exp
, aspect_id
, currency_iso_cd
, curr_tot_id
, dat_formdate
, miss_item_cnt_cy
, miss_item_cnt_fa_cy
, miss_item_cnt_py
, miss_item_cnt_fa_py
, store_day_cnt_cy
, store_day_cnt_fa_cy
, store_day_cnt_py
, store_day_cnt_fa_py
, miss_item_fg_cy
, miss_item_fg_fa_cy
, miss_item_fg_py
, miss_item_fg_fa_py
)
AS
SELECT
  wgi.client_id
, wgi.account_manager_id
, wgi.sales_manager_id
, wgi.move_to_store_id
, wgi.wh_id
, wgi.wh_id_exp
, wgi.aspect_id
, wgi.currency_iso_cd
, wgi.curr_tot_id
, wgi.dat_formdate
, CASE WHEN MAX(skipped_fg_cy) = 1 OR SUM(wgi.miss_item_cnt_cy) > COALESCE(p.val_int, 300) THEN 0 ELSE SUM(wgi.miss_item_cnt_cy) END
, CASE WHEN MAX(skipped_fg_fa_cy) = 1 OR SUM(wgi.miss_item_cnt_fa_cy) > COALESCE(p.val_int, 300) THEN 0 ELSE SUM(wgi.miss_item_cnt_fa_cy) END
, CASE WHEN MAX(skipped_fg_py) = 1 OR SUM(wgi.miss_item_cnt_py) > COALESCE(p.val_int, 300) THEN 0 ELSE SUM(wgi.miss_item_cnt_py) END
, CASE WHEN MAX(skipped_fg_fa_py) = 1 OR SUM(wgi.miss_item_cnt_fa_py) > COALESCE(p.val_int, 300) THEN 0 ELSE SUM(wgi.miss_item_cnt_fa_py) END

, CASE WHEN MAX(skipped_fg_cy) = 0 AND SUM(wgi.miss_item_cnt_cy) IS NOT NULL AND SUM(wgi.miss_item_cnt_cy) <= COALESCE(p.val_int, 300) THEN MAX(wgi.store_day_cnt_cy) ELSE NULL END
, CASE WHEN MAX(skipped_fg_fa_cy) = 0 AND SUM(wgi.miss_item_cnt_fa_cy) IS NOT NULL AND SUM(wgi.miss_item_cnt_fa_cy) <= COALESCE(p.val_int, 300) THEN MAX(wgi.store_day_cnt_fa_cy) ELSE NULL END
, CASE WHEN MAX(skipped_fg_py) = 0 AND SUM(wgi.miss_item_cnt_py) IS NOT NULL AND SUM(wgi.miss_item_cnt_py) <= COALESCE(p.val_int, 300) THEN MAX(wgi.store_day_cnt_py) ELSE NULL END
, CASE WHEN MAX(skipped_fg_fa_py) = 0 AND SUM(wgi.miss_item_cnt_fa_py) IS NOT NULL AND SUM(wgi.miss_item_cnt_fa_py) <= COALESCE(p.val_int, 300) THEN MAX(wgi.store_day_cnt_fa_py) ELSE NULL END

, CASE WHEN MAX(skipped_fg_cy) = 0 AND SUM(wgi.miss_item_cnt_cy) BETWEEN 1 AND COALESCE(p.val_int, 300) THEN MAX(wgi.miss_item_fg_cy) ELSE 0 END
, CASE WHEN MAX(skipped_fg_fa_cy) = 0 AND SUM(wgi.miss_item_cnt_fa_cy) BETWEEN 1 AND COALESCE(p.val_int, 300) THEN MAX(wgi.miss_item_fg_fa_cy) ELSE 0 END
, CASE WHEN MAX(skipped_fg_py) = 0 AND SUM(wgi.miss_item_cnt_py) BETWEEN 1 AND COALESCE(p.val_int, 300) THEN MAX(wgi.miss_item_fg_py) ELSE 0 END
, CASE WHEN MAX(skipped_fg_fa_py) = 0 AND SUM(wgi.miss_item_cnt_fa_py) BETWEEN 1 AND COALESCE(p.val_int, 300) THEN MAX(wgi.miss_item_fg_fa_py) ELSE 0 END
FROM P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_WGI_MISS_ITM_1 AS wgi
LEFT OUTER JOIN P_LEW_MART_LEAD.v_ref_parameter_vt_1 AS p
ON wgi.client_id = p.client_id
AND p.param_id = 1
GROUP BY
  wgi.client_id
, wgi.account_manager_id
, wgi.sales_manager_id
, wgi.move_to_store_id
, wgi.wh_id
, wgi.wh_id_exp
, wgi.aspect_id
, wgi.currency_iso_cd
, wgi.curr_tot_id
, wgi.dat_formdate
, COALESCE(p.val_int, 300)
;