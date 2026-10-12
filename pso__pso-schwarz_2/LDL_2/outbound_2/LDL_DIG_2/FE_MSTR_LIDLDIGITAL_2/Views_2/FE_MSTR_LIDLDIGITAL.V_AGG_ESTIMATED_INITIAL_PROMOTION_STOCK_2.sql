CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_estimated_initial_promotion_stock_2 AS
-- TODO: faulty(?) data forces us to remove entries from this view. we might want to remove this once the data issue is resolved (updated promotions get new PROMO_IDs instead of updating existing PROMO_IDs)

SELECT CASE
  WHEN wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(wshop_cd, '-1')
  END AS wshop_cd,
 IFNULL(prod_sid, -1) AS prod_sid,
 promo_start_dt,
 promo_sale_start_dt,
 IFNULL(promo_id, -1) AS promo_id,
 IFNULL(prod_variant_sid, -1) AS prod_variant_sid,
 estimated_init_promo_stock,
 stock_distribution_pct
FROM ldl_dig_lec_share.v_agg_estimated_initial_promotion_stock_core_view_2
WHERE promo_id IN (SELECT promo_id
   FROM ldl_dig_fe_mstr_lidldigital.v_agg_sales_promotion_2);