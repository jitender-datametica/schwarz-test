CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_fact_kfl_client_item_day_2 (lob_cd, kfl_client_id, kfl_item_nr,
cal_dt, curr_cd, kfl_adv_week, kfl_rcv_qty, ldl_buying_rcv_net_val, ldl_retail_rcv_net_val,
kfl_consolidated_promo_item_type_cd) AS SELECT lob_cd,
 kfl_client_id,
  CASE
  WHEN lob_cd = 'KFL' AND kfl_client_id = 1
  THEN CAST(kfl_item_nr / 100 AS BIGNUMERIC)
  WHEN lob_cd = 'KFL' AND kfl_client_id > 1
  THEN CAST(kfl_item_nr / 10 AS BIGNUMERIC)
  WHEN lob_cd = 'LDL'
  THEN CAST(kfl_item_nr / 100 AS BIGNUMERIC)
  ELSE NULL
  END AS kfl_item_nr,
 cal_dt,
 curr_cd,
 kfl_adv_week,
 kfl_rcv_qty,
 ldl_buying_rcv_net_val,
 ldl_retail_rcv_net_val,
 kfl_consolidated_promo_item_type_cd
FROM nfpow_core.t_fact_kfl_client_item_day_2;