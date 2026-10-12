CREATE OR REPLACE VIEW ldl_dig_transfer.v_amp_export_abverkaufsquoten AS WITH TMP_ETL_AKTIONSPLANMENGEN AS (SELECT
   CONCAT(T1.wshop_cd, T1.prod_sid, T1.promo_dt) AS pk,
   CONCAT(T1.wshop_cd, T1.prod_sid) AS artikel_os,
   T1.wshop_cd AS os,
   T1.prod_sid,
   T2.prod_nr AS kopfartnr,
   IF(ROUND(SAFE_CAST(T2.ian_nr AS BIGNUMERIC), 0) IS NULL, T2.prod_nr, T2.ian_nr) AS lidlnummer,
   T1.promo_dt AS verkaufsstart,
   T1.sale_promo_type_cd AS werbeimpuls,
   T1.promo_price_gross_local_val AS akp_brutto_local_val,
   T1.curr_cd,
   T1.tgt_prod_sale_qty AS anfangsbestand,
   T1.promo_dur_week_cnt AS abverkaufshorizont
  FROM ldl_dig_core.t_fact_sales_promotion_target AS T1
   INNER JOIN ldl_dig_core.t_dim_product AS T2 ON T1.prod_sid = T2.prod_sid AND T2.dwh_valid_fg
  WHERE T1.promo_dt >= IF(DATE_TRUNC(CURRENT_DATE, MONTH) = LAST_DAY(DATE_TRUNC(CURRENT_DATE, MONTH)), LAST_DAY(DATE_ADD(DATE_TRUNC(CURRENT_DATE
        , MONTH), INTERVAL - 6 MONTH)), DATE_ADD(DATE_TRUNC(CURRENT_DATE, MONTH), INTERVAL - 6 MONTH))),
 AKTIONSPLANMENGEN AS (SELECT *
  FROM TMP_ETL_AKTIONSPLANMENGEN
  WHERE pk IN (SELECT FIRST_VALUE(CONCAT(T10.wshop_cd, T10.prod_sid, T10.promo_dt)) OVER (PARTITION BY CONCAT(T10.wshop_cd
          , T10.prod_sid) ORDER BY T10.tgt_prod_sale_qty IS NULL DESC, T10.tgt_prod_sale_qty DESC, T10.promo_dt IS NULL
         DESC, T10.promo_dt DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS a1928350188
     FROM ldl_dig_core.t_fact_sales_promotion_target AS T10
      INNER JOIN ldl_dig_core.t_dim_product AS T20 ON T10.prod_sid = T20.prod_sid AND T20.dwh_valid_fg
     WHERE T10.promo_dt >= IF(DATE_TRUNC(CURRENT_DATE, MONTH) = LAST_DAY(DATE_TRUNC(CURRENT_DATE, MONTH)), LAST_DAY(DATE_ADD(DATE_TRUNC(CURRENT_DATE
           , MONTH), INTERVAL - 6 MONTH)), DATE_ADD(DATE_TRUNC(CURRENT_DATE, MONTH), INTERVAL - 6 MONTH)))), ARTIKEL AS
  (SELECT T11.wshop_cd,
   T11.prod_sid,
   T11.prod_nr,
   T11.prod_variant_sid,
   T11.prod_variant_nr,
   IF(ROUND(SAFE_CAST(T21.ian_nr AS BIGNUMERIC), 0) IS NULL, T11.prod_nr, T21.ian_nr) AS ian_nr,
   T11.reg_prod_variant_name,
   T11.reg_prod_variant_descr,
   T11.tax_class_cd,
    CASE
    WHEN STRPOS(UPPER(T11.reg_prod_variant_descr), 'FARBE:') <> 0
    THEN CONCAT('"""', LEFT(RTRIM(CASE
        WHEN UPPER(T11.reg_prod_variant_descr) IS NOT NULL
        THEN IFNULL(SPLIT(UPPER(T11.reg_prod_variant_descr), 'FARBE:')[SAFE_OFFSET(- 1)], '')
        ELSE NULL
        END), 44), '"""')
    ELSE CASE
     WHEN STRPOS(UPPER(T11.reg_prod_variant_descr), 'ART:') <> 0
     THEN CONCAT('"""', LEFT(RTRIM(CASE
         WHEN UPPER(T11.reg_prod_variant_descr) IS NOT NULL
         THEN IFNULL(SPLIT(UPPER(T11.reg_prod_variant_descr), 'ART:')[SAFE_OFFSET(- 1)], '')
         ELSE NULL
         END), 44), '"""')
     ELSE NULL
     END
    END AS style_amp
  FROM ldl_dig_core.t_rel_product_variant_regional AS T11
   INNER JOIN ldl_dig_core.t_dim_product_variant AS T21 ON T11.prod_variant_sid = T21.prod_variant_sid AND T11.dwh_valid_fg
      AND T21.dwh_valid_fg), TMP_ETL_ABVERKAUFSQUOTEN_1 AS (SELECT DISTINCT CONCAT(t1.os, IFNULL(t1.lidlnummer, t1.kopfartnr
     ), IFNULL(t2.style_amp, '""""""')) AS join_key_tmp,
   CONCAT('"""', 'OS', t1.os, '"""') AS land,
   t1.os,
   IFNULL(t1.lidlnummer, t1.kopfartnr) AS ian,
   FORMAT_DATE('%d.%m.%Y', t1.verkaufsstart) AS verkaufsstart_u0028_werbetermin_u0029_,
   IFNULL(t2.style_amp, '""""""') AS style
  FROM AKTIONSPLANMENGEN AS t1
   LEFT JOIN ARTIKEL AS t2 ON t1.prod_sid = t2.prod_sid), TMP_ETL_ARTIKEL AS (SELECT CONCAT(wshop_cd, prod_variant_sid)
   AS join_key_tmp,
   wshop_cd,
   prod_variant_sid,
   IFNULL(ian_nr, prod_nr) AS ian,
   IFNULL(style_amp, '""""""') AS style
  FROM ARTIKEL), TMP_ETL_KUNDENAUFTRAG_1 AS (SELECT wshop_cd,
   cust_order_sid,
   cust_order_dt,
   cust_order_nr,
   prod_variant_sid,
   cust_order_pos_nr,
   prod_qty,
   curr_cd,
   prod_price_gross_local_val,
   delivery_cost_gross_local_val,
   delivery_paushal_gross_local_val,
   tax_class_cd,
   cust_order_type_cd,
   is_part_of_bundle_header_cnt_fg
  FROM ldl_dig_core.t_fact_customer_order_line
  WHERE cust_order_dt >= IF(DATE_TRUNC(CURRENT_DATE, MONTH) = LAST_DAY(DATE_TRUNC(CURRENT_DATE, MONTH)), LAST_DAY(DATE_ADD(DATE_TRUNC(CURRENT_DATE
        , MONTH), INTERVAL - 6 MONTH)), DATE_ADD(DATE_TRUNC(CURRENT_DATE, MONTH), INTERVAL - 6 MONTH))
   AND (wshop_cd = 'DE' AND is_part_of_bundle_header_cnt_fg OR wshop_cd <> 'DE' AND is_part_of_bundle_pos_cnt_fg)),
 KUNDENAUFTRAG AS (SELECT T23.prod_sid,
   T23.prod_nr,
   t1.wshop_cd,
   t1.cust_order_sid,
   t1.cust_order_dt,
   t1.cust_order_nr,
   t1.prod_variant_sid,
   t1.cust_order_pos_nr,
   ROUND(CAST(t1.prod_qty AS NUMERIC), 2) AS prod_qty,
   t1.curr_cd,
   CAST(t1.prod_price_gross_local_val AS BIGNUMERIC) AS prod_price_gross_local_val,
   CAST(t1.delivery_cost_gross_local_val AS BIGNUMERIC) AS delivery_cost_gross_local_val,
   CAST(t1.delivery_paushal_gross_local_val AS BIGNUMERIC) AS delivery_paushal_gross_local_val,
   t1.tax_class_cd,
   t1.cust_order_type_cd,
   t1.is_part_of_bundle_header_cnt_fg,
   CAST(t1.prod_price_gross_local_val / T3.exchange_rate AS BIGNUMERIC) AS prod_price_gross_eur
  FROM TMP_ETL_KUNDENAUFTRAG_1 AS t1
   LEFT JOIN ldl_dig_core.t_dim_product_variant AS T23 ON t1.prod_variant_sid = T23.prod_variant_sid AND T23.dwh_valid_fg
    
   LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate AS T3 ON t1.curr_cd = T3.from_curr_cd AND T3.curr_exchange_rate_type_cd
       = 'F' AND t1.cust_order_dt BETWEEN T3.active_from_dt AND T3.active_to_dt), TMP_ETL_KUNDENAUFTRAG AS (SELECT
   CONCAT(wshop_cd, prod_variant_sid) AS join_key_tmp,
   wshop_cd,
   prod_variant_sid,
   SUM(prod_qty) AS bestellmenge
  FROM KUNDENAUFTRAG
  GROUP BY wshop_cd,
   prod_variant_sid), TMP_ETL_KUNDENAUFTRAG_AGGR AS (SELECT t1.wshop_cd,
   t1.ian,
   t1.prod_variant_sid,
   t1.style,
   IFNULL(t2.bestellmenge, 0) AS bestellmenge
  FROM TMP_ETL_ARTIKEL AS t1
   LEFT JOIN TMP_ETL_KUNDENAUFTRAG AS t2 ON t1.join_key_tmp = t2.join_key_tmp), TMP_ETL_ABVERKAUFSQUOTEN_2 AS (SELECT
   CONCAT(wshop_cd, ian, style) AS join_key_tmp,
   wshop_cd,
   ian,
   style,
   SUM(bestellmenge) AS bestellmenge_aggr,
   SUM(SUM(bestellmenge)) OVER (PARTITION BY wshop_cd, ian RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   bestellmenge_total
  FROM TMP_ETL_KUNDENAUFTRAG_AGGR
  GROUP BY wshop_cd,
   ian,
   style), TMP_ETL_ABVERKAUFSQUOTEN_3 AS (SELECT t1.land,
   t1.ian,
   t1.verkaufsstart_u0028_werbetermin_u0029_,
   t1.style,
   ROUND(IF(t2.bestellmenge_total = 0, 0, SAFE_DIVIDE(t2.bestellmenge_aggr, t2.bestellmenge_total)) * 100, 2) AS wert
  FROM TMP_ETL_ABVERKAUFSQUOTEN_1 AS t1
   LEFT JOIN TMP_ETL_ABVERKAUFSQUOTEN_2 AS t2 ON t1.join_key_tmp = t2.join_key_tmp) (SELECT *
  FROM (SELECT *
     FROM TMP_ETL_ABVERKAUFSQUOTEN_3 AS t1
     UNION DISTINCT
     SELECT t54.land_new AS land,
      t2.ian,
      t2.verkaufsstart_u0028_werbetermin_u0029_,
      t2.style,
      CAST(t2.wert AS NUMERIC) AS wert
     FROM TMP_ETL_ABVERKAUFSQUOTEN_3 AS t2
      RIGHT JOIN (SELECT '"""OSAT"""' AS land_new
        UNION ALL
        SELECT '"""OSDK"""' AS land_new
        UNION ALL
        SELECT '"""OSHU"""' AS land_new
        UNION ALL
        SELECT '"""OSFR"""' AS land_new) AS t54 ON t2.land = '"""OSDE"""'));