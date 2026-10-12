CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_qv_agg_store_day_miss_itm (client_id, account_manager_id, sales_manager_id
, move_to_store_id, wh_id, wh_id_exp, aspect_id, currency_iso_cd, curr_tot_id, dat_formdate, miss_item_cnt_cy,
miss_item_cnt_fa_cy, miss_item_cnt_py, miss_item_cnt_fa_py, store_day_cnt_cy, store_day_cnt_fa_cy, store_day_cnt_py,
store_day_cnt_fa_py, miss_item_fg_cy, miss_item_fg_fa_cy, miss_item_fg_py, miss_item_fg_fa_py) AS SELECT t0.client_id,
 t0.account_manager_id,
 t0.sales_manager_id,
 t0.move_to_store_id,
 t0.wh_id,
 t0.wh_id_exp,
 t0.aspect_id,
 t0.currency_iso_cd,
 t0.curr_tot_id,
 t0.dat_formdate,
  CASE
  WHEN t0.a0 = 1 OR t0.a0_0 > t0.dm__operand
  THEN 0
  ELSE t0.a0_0
  END AS miss_item_cnt_cy,
  CASE
  WHEN t0.a0_1 = 1 OR t0.a0_2 > t0.dm__operand
  THEN 0
  ELSE t0.a0_2
  END AS miss_item_cnt_fa_cy,
  CASE
  WHEN t0.a0_3 = 1 OR t0.a0_4 > t0.dm__operand
  THEN 0
  ELSE t0.a0_4
  END AS miss_item_cnt_py,
  CASE
  WHEN t0.a0_5 = 1 OR t0.a0_6 > t0.dm__operand
  THEN 0
  ELSE t0.a0_6
  END AS miss_item_cnt_fa_py,
  CASE
  WHEN t0.a0 = 0 AND t0.a0_0 <= t0.dm__operand
  THEN t0.a0_7
  ELSE NULL
  END AS store_day_cnt_cy,
  CASE
  WHEN t0.a0_1 = 0 AND t0.a0_2 <= t0.dm__operand
  THEN t0.a0_8
  ELSE NULL
  END AS store_day_cnt_fa_cy,
  CASE
  WHEN t0.a0_3 = 0 AND t0.a0_4 <= t0.dm__operand
  THEN t0.a0_9
  ELSE NULL
  END AS store_day_cnt_py,
  CASE
  WHEN t0.a0_5 = 0 AND t0.a0_6 <= t0.dm__operand
  THEN t0.a0_10
  ELSE NULL
  END AS store_day_cnt_fa_py,
  CASE
  WHEN t0.a0 = 0 AND t0.a0_0 BETWEEN 1 AND t0.dm__operand
  THEN t0.a0_11
  ELSE 0
  END AS miss_item_fg_cy,
  CASE
  WHEN t0.a0_1 = 0 AND t0.a0_2 BETWEEN 1 AND t0.dm__operand
  THEN t0.a0_12
  ELSE 0
  END AS miss_item_fg_fa_cy,
  CASE
  WHEN t0.a0_3 = 0 AND t0.a0_4 BETWEEN 1 AND t0.dm__operand
  THEN t0.a0_13
  ELSE 0
  END AS miss_item_fg_py,
  CASE
  WHEN t0.a0_5 = 0 AND t0.a0_6 BETWEEN 1 AND t0.dm__operand
  THEN t0.a0_14
  ELSE 0
  END AS miss_item_fg_fa_py
FROM (SELECT WGI.client_id,
   WGI.account_manager_id,
   WGI.sales_manager_id,
   WGI.move_to_store_id,
   WGI.wh_id,
   WGI.wh_id_exp,
   WGI.aspect_id,
   WGI.currency_iso_cd,
   WGI.curr_tot_id,
   WGI.dat_formdate,
   COALESCE(P.val_int, 300) AS dm__operand,
   MAX(WGI.skipped_fg_cy) AS a0,
   SUM(WGI.miss_item_cnt_cy) AS a0_0,
   MAX(WGI.skipped_fg_fa_cy) AS a0_1,
   SUM(WGI.miss_item_cnt_fa_cy) AS a0_2,
   MAX(WGI.skipped_fg_py) AS a0_3,
   SUM(WGI.miss_item_cnt_py) AS a0_4,
   MAX(WGI.skipped_fg_fa_py) AS a0_5,
   SUM(WGI.miss_item_cnt_fa_py) AS a0_6,
   MAX(WGI.store_day_cnt_cy) AS a0_7,
   MAX(WGI.store_day_cnt_fa_cy) AS a0_8,
   MAX(WGI.store_day_cnt_py) AS a0_9,
   MAX(WGI.store_day_cnt_fa_py) AS a0_10,
   MAX(WGI.miss_item_fg_cy) AS a0_11,
   MAX(WGI.miss_item_fg_fa_cy) AS a0_12,
   MAX(WGI.miss_item_fg_py) AS a0_13,
   MAX(WGI.miss_item_fg_fa_py) AS a0_14
  FROM ldl_p_lew_mart_lead.t_qv_agg_store_day_wgi_miss_itm AS WGI
   LEFT JOIN ldl_p_lew_mart_lead.v_ref_parameter_vt AS P ON WGI.client_id = P.client_id AND P.param_id = 1
  GROUP BY WGI.client_id,
   WGI.account_manager_id,
   WGI.sales_manager_id,
   WGI.move_to_store_id,
   WGI.wh_id,
   WGI.wh_id_exp,
   WGI.aspect_id,
   WGI.currency_iso_cd,
   WGI.curr_tot_id,
   WGI.dat_formdate,
   dm__operand) AS t0;