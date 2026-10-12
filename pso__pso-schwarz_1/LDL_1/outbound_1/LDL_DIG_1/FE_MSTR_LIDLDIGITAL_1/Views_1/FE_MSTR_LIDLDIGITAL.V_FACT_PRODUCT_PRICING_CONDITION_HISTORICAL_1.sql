CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_pricing_condition_historical_1 (wshop_cd, curr_cd,
prod_variant_sid, price_type_cd, active_from_dt, active_from_tmsp, active_to_dt, active_to_tmsp, price_val, gc_lc_cd) AS
SELECT IFNULL(PPC.wshop_cd, '-1') AS wshop_cd,
 IFNULL(CER.to_curr_cd, '-1') AS curr_cd,
 IFNULL(PPC.prod_variant_sid, -1) AS prod_variant_sid,
 IFNULL(PPC.price_type_cd, '-1') AS price_type_cd,
 DATE(PPC.active_from_tmsp) AS active_from_dt,
 PPC.active_from_tmsp,
 DATE(PPC.active_to_tmsp) AS active_to_dt,
 PPC.active_to_tmsp,
 ROUND(PPC.price_val / CER.exchange_rate, 3) AS price_val,
 'GC' AS gc_lc_cd
FROM ldl_dig_lec_share.v_fact_product_pricing_condition_1 AS PPC
 INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate_1 AS CER ON PPC.curr_cd = CER.from_curr_cd AND DATE(PPC.active_from_tmsp
      ) BETWEEN CER.active_from_dt AND CER.active_to_dt AND CER.curr_exchange_rate_type_cd = 'F' AND CER.to_curr_cd =
   'EUR'
UNION ALL
SELECT IFNULL(wshop_cd, '-1') AS wshop_cd,
 IFNULL(curr_cd, '-1') AS curr_cd,
 IFNULL(prod_variant_sid, -1) AS prod_variant_sid,
 IFNULL(price_type_cd, '-1') AS price_type_cd,
 DATE(active_from_tmsp) AS active_from_dt,
 active_from_tmsp,
 DATE(active_to_tmsp) AS active_to_dt,
 active_to_tmsp,
 price_val,
 'LC' AS gc_lc_cd
FROM ldl_dig_lec_share.v_fact_product_pricing_condition_1 AS PPC
WHERE curr_cd <> 'EUR'
UNION ALL
SELECT IFNULL(PPC.wshop_cd, '-1') AS wshop_cd,
 IFNULL(RWC.curr_cd, '-1') AS curr_cd,
 IFNULL(PPC.prod_variant_sid, -1) AS prod_variant_sid,
 IFNULL(PPC.price_type_cd, '-1') AS price_type_cd,
 DATE(PPC.active_from_tmsp) AS active_from_dt,
 PPC.active_from_tmsp,
 DATE(PPC.active_to_tmsp) AS active_to_dt,
 PPC.active_to_tmsp,
 ROUND(PPC.price_val * CER.exchange_rate, 3) AS price_val,
 'LC' AS gc_lc_cd
FROM ldl_dig_lec_share.v_fact_product_pricing_condition_1 AS PPC
 INNER JOIN ldl_dig_lec_share.v_rel_webshop_currency_1 AS RWC ON PPC.wshop_cd = RWC.wshop_cd AND RWC.dwh_valid_fg
 INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate_1 AS CER ON RWC.curr_cd = CER.from_curr_cd AND DATE(PPC.active_from_tmsp
     ) BETWEEN CER.active_from_dt AND CER.active_to_dt AND CER.curr_exchange_rate_type_cd = 'F'
WHERE PPC.curr_cd = 'EUR'
 AND RWC.curr_cd <> 'EUR';