CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_fact_kfl_gtp_item_day_2 (lob_cd, kfl_client_id, kfl_gtp_nr,
kfl_gtp_subsidiary_type_id, kfl_item_nr, cal_dt, curr_cd, kfl_adv_week, kfl_adjust_sales_gross_val,
kfl_adjust_sales_net_val, kfl_adjust_sales_net_val_kalk, kfl_adjust_adv_sales_net_val, kfl_adjust_adv_sales_qty,
kfl_adjust_af_sales_qty, kfl_return_gross_val, kfl_return_net_val, kfl_adjust_sales_qty, kfl_return_qty, kfl_rcv_qty,
kfl_buying_sales_net_val, kfl_total_writeoff_net_val, kfl_part_writeoff_net_val, ldl_writeoff_net_val,
kfl_consolidated_promo_item_type_cd, posten_kz_as_was_plus_sonderaktion) AS SELECT lob_cd,
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
 cal_dt,
 curr_cd,
 kfl_adv_week,
 kfl_adjust_sales_gross_val,
 kfl_adjust_sales_net_val,
  CASE
  WHEN lob_cd = 'KFL'
  THEN kfl_adjust_sales_net_val
  ELSE 0
  END AS kfl_adjust_sales_net_val_kalk,
 kfl_adjust_adv_sales_net_val,
 kfl_adjust_adv_sales_qty,
  kfl_adjust_sales_qty - kfl_adjust_adv_sales_qty AS kfl_adjust_af_sales_qty,
 kfl_return_gross_val,
 kfl_return_net_val,
 kfl_adjust_sales_qty,
 kfl_return_qty,
 kfl_rcv_qty,
 kfl_buying_sales_net_val,
 kfl_total_writeoff_net_val,
 kfl_part_writeoff_net_val,
 ldl_writeoff_net_val,
 kfl_consolidated_promo_item_type_cd,
  CASE
  WHEN lob_cd = 'KFL' AND kfl_adjust_sales_qty - kfl_adjust_adv_sales_qty <> 0 AND kfl_consolidated_promo_item_type_cd =
    'PN'
  THEN 'Postenart./Sortimentsart. SA'
  WHEN lob_cd = 'KFL' AND kfl_adjust_sales_qty - kfl_adjust_adv_sales_qty <> 0 AND kfl_consolidated_promo_item_type_cd =
    'SO'
  THEN 'Sortimentsartikel AF'
  WHEN lob_cd = 'KFL' AND (kfl_adjust_sales_qty IS NULL OR kfl_adjust_adv_sales_qty IS NULL OR kfl_adjust_sales_qty -
        kfl_adjust_adv_sales_qty = 0) AND kfl_consolidated_promo_item_type_cd = 'SO'
  THEN 'Postenart./Sortimentsart. SA'
  ELSE ''
  END AS posten_kz_as_was_plus_sonderaktion
FROM nfpow_core.t_fact_kfl_gtp_item_day_2
WHERE kfl_adjust_sales_gross_val <> 0
 OR kfl_adjust_sales_net_val <> 0
 OR CASE
   WHEN lob_cd = 'KFL'
   THEN kfl_adjust_sales_net_val
   ELSE 0
   END <> 0
 OR kfl_adjust_adv_sales_net_val <> 0
 OR kfl_return_gross_val <> 0
 OR kfl_return_net_val <> 0
 OR kfl_adjust_sales_qty <> 0
 OR kfl_adjust_adv_sales_qty <> 0
 OR kfl_return_qty <> 0
 OR kfl_rcv_qty <> 0
 OR kfl_buying_sales_net_val <> 0
 OR kfl_total_writeoff_net_val <> 0
 OR kfl_part_writeoff_net_val <> 0 AND lob_cd = 'LDL';