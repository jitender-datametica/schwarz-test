CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_price_supplier AS WITH CTE AS (SELECT supplier_sid,
   wshop_cd,
   IFNULL(prod_variant_sid, -1) AS prod_variant_sid,
   active_to_tmsp,
   active_from_tmsp,
    CASE
    WHEN curr_cd = ''
    THEN '-1'
    ELSE IFNULL(curr_cd, '-1')
    END AS curr_cd,
    CASE
    WHEN price_type_cd = 'EKP'
    THEN price_val
    ELSE NULL
    END AS ekp_price_eur_val,
    CASE
    WHEN price_type_cd = 'FKZ'
    THEN price_val
    ELSE NULL
    END AS fkz_price_eur_val
  FROM ldl_dig_lec_share.v_fact_product_price_supplier AS PPS_FACT
  WHERE curr_cd = 'EUR'
   AND CURRENT_TIMESTAMP() BETWEEN active_from_tmsp AND active_to_tmsp) (SELECT supplier_sid,
   wshop_cd,
   prod_variant_sid,
   curr_cd,
   MAX(ekp_price_eur_val) AS ekp_price_val,
   MAX(fkz_price_eur_val) AS fkz_price_val,
   'GC' AS gc_lc_cd,
   MAX(ekp_price_eur_val) AS ekp_price_eur_val,
   MAX(fkz_price_eur_val) AS fkz_price_eur_val
  FROM CTE
  GROUP BY supplier_sid,
   wshop_cd,
   prod_variant_sid,
   curr_cd,
   gc_lc_cd);