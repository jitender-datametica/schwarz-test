CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_fact_kfl_gtp_item_gtin_day_2 (lob_cd, kfl_client_id, kfl_gtp_nr,
kfl_gtp_subsidiary_type_id, kfl_item_nr, gtin_nr, cal_dt, curr_cd, kfl_consolidated_promo_item_type_cd, kfl_adv_week,
kfl_adjust_sales_gross_val, kfl_adjust_sales_net_val, kfl_return_gross_val, kfl_return_net_val, kfl_adjust_sales_qty,
kfl_return_qty) AS SELECT lob_cd,
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
 gtin_nr,
 cal_dt,
 curr_cd,
 kfl_consolidated_promo_item_type_cd,
 kfl_adv_week,
 kfl_adjust_sales_gross_val,
 kfl_adjust_sales_net_val,
 kfl_return_gross_val,
 kfl_return_net_val,
 kfl_adjust_sales_qty,
 kfl_return_qty
FROM nfpow_core.t_fact_kfl_gtp_item_gtin_day_2;