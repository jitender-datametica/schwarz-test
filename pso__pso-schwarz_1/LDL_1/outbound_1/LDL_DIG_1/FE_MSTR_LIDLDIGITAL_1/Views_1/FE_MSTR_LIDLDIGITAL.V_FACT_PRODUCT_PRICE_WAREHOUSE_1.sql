CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_price_warehouse_1 AS SELECT wh_sid,
 prod_variant_sid,
 price_type_cd,
 price_group_cd,
 curr_cd,
 'GC' AS gc_lc_cd,
 price_eur_val AS price_val,
 wh_cd,
 prod_variant_nr,
 is_substitution_price_fg
FROM ldl_dig_fe_mstr_lidldigital.v_fact_product_price_warehouse_no_gc_lc_1
UNION ALL
SELECT wh_sid,
 prod_variant_sid,
 price_type_cd,
 price_group_cd,
 curr_cd,
 'LC' AS gc_lc_cd,
 price_local_val AS price_val,
 wh_cd,
 prod_variant_nr,
 is_substitution_price_fg
FROM ldl_dig_fe_mstr_lidldigital.v_fact_product_price_warehouse_no_gc_lc_1
WHERE curr_cd <> 'EUR';