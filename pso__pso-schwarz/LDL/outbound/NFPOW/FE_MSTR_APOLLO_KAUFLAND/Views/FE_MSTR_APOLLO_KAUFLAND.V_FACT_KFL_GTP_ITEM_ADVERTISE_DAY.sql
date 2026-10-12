CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_fact_kfl_gtp_item_advertise_day (lob_cd, kfl_client_id,
kfl_gtp_nr, kfl_gtp_subsidiary_type_id, kfl_item_nr, cal_week, kfl_adv_period_type_id, curr_cd, adv_dt, kfl_adv_week,
kfl_adjust_adv_sales_7_qty, kfl_adv_stock_qty, kfl_gtp_cnt, ldl_adjust_adv_sales_7_qty, ldl_adv_stock_qty, ldl_gtp_cnt,
kfl_consolidated_promo_item_type_cd) AS SELECT lob_cd,
 kfl_client_id,
 kfl_gtp_nr,
 kfl_gtp_subsidiary_type_id,
  CASE
  WHEN lob_cd = 'KFL' AND kfl_client_id = 1
  THEN CAST(kfl_item_nr / 100 AS BIGNUMERIC)
  WHEN lob_cd = 'KFL' AND kfl_client_id > 1
  THEN CAST(kfl_item_nr / 10 AS BIGNUMERIC)
  WHEN lob_cd = 'LDL'
  THEN CAST(kfl_item_nr / 100 AS BIGNUMERIC)
  ELSE NULL
  END AS kfl_item_nr,
 cal_week,
 kfl_adv_period_type_id,
 curr_cd,
 adv_dt,
 kfl_adv_week,
 kfl_adjust_adv_sales_7_qty,
 kfl_adv_stock_qty,
 kfl_gtp_cnt,
 ldl_adjust_adv_sales_7_qty,
 ldl_adv_stock_qty,
 ldl_gtp_cnt,
 kfl_consolidated_promo_item_type_cd
FROM nfpow_core.t_fact_kfl_gtp_item_advertise_day;