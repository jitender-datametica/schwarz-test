/* This view is referenced in V_FACT_ARTICLE_MASTER. */
-- this section is kept for a transition period. it can be removed once the MSTR reports referencing this view have switched to using the new columns

-- this section is kept for a transition period. it can be removed once the MSTR reports referencing this view have switched to using the new columns

CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_price_sale_ivp_gld_vkp_1 AS SELECT wshop_cd,
 cal_dt,
 prod_variant_sid,
 'EUR' AS curr_cd,
 gld_price_net_eur_val AS gld_price_net_val,
 ivp_price_net_eur_val AS ivp_price_net_val,
 vkp_price_net_eur_val AS vkp_price_net_val,
 vkp_price_gross_eur_val AS vkp_price_gross_val,
 first_valid_price_fg,
 'GC' AS gc_lc_cd,
 gld_price_net_eur_val,
 gld_price_net_local_val,
 ivp_price_net_eur_val,
 ivp_price_net_local_val,
 vkp_price_net_local_val,
 vkp_price_net_eur_val,
 vkp_price_gross_local_val,
 vkp_price_gross_eur_val -- end section

FROM ldl_dig_fe_mstr_lidldigital.v_fact_product_price_sale_ivp_gld_vkp_no_gc_lc_1
UNION ALL
SELECT wshop_cd,
 cal_dt,
 prod_variant_sid,
 curr_cd,
 gld_price_net_local_val AS gld_price_net_val,
 ivp_price_net_local_val AS ivp_price_net_val,
 vkp_price_net_local_val AS vkp_price_net_val,
 vkp_price_gross_local_val AS vkp_price_gross_val,
 first_valid_price_fg,
 'LC' AS gc_lc_cd,
 gld_price_net_eur_val,
 gld_price_net_local_val,
 ivp_price_net_eur_val,
 ivp_price_net_local_val,
 vkp_price_net_local_val,
 vkp_price_net_eur_val,
 vkp_price_gross_local_val,
 vkp_price_gross_eur_val -- end section

FROM ldl_dig_fe_mstr_lidldigital.v_fact_product_price_sale_ivp_gld_vkp_no_gc_lc_1
WHERE curr_cd <> 'EUR';