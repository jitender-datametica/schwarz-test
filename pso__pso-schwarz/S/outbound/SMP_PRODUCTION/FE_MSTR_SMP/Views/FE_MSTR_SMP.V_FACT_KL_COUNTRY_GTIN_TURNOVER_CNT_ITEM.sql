CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_kl_country_gtin_turnover_cnt_item (day_dt, country_id, gtin_id
, kl_gtin_id, art_id_ref, art_id_ref_kl, lp_turnover_gross, lp_turnover_net, lp_cnt_item, buyer, turnover_gross,
cnt_item, vk_brutto) AS SELECT FACT.day_dt,
 FACT.country_id,
 CAST(ART.gtin_id AS STRING) AS gtin_id,
 CAST(ART.gtin_id AS STRING) AS kl_gtin_id,
 CAST(FACT.art_id_ref AS STRING) AS art_id_ref,
 CAST(CAST(CASE
    WHEN FACT.division_id = 'KFL'
    THEN ART.kl_art_id
    ELSE FACT.art_id_ref
    END AS BIGNUMERIC) AS STRING) AS art_id_ref_kl,
 SUM(CASE
   WHEN FACT.shopper_id_ref IS NOT NULL
   THEN FACT.sales_gross_val
   ELSE 0
   END) AS lp_turnover_gross,
 SUM(CASE
   WHEN FACT.shopper_id_ref IS NOT NULL
   THEN FACT.sales_net_val
   ELSE 0
   END) AS lp_turnover_net,
 SUM(CASE
   WHEN FACT.shopper_id_ref IS NOT NULL
   THEN FACT.sales_piece_qty
   ELSE 0
   END) AS lp_cnt_item,
 COUNT(DISTINCT FACT.shopper_id_ref) AS buyer,
 SUM(FACT.sales_gross_val) AS turnover_gross,
 SUM(FACT.sales_piece_qty) AS cnt_item,
  SUM(FACT.sales_gross_val) / SUM(FACT.sales_piece_qty) AS vk_brutto
FROM smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day AS FACT
 LEFT JOIN smp_production_core_rel.t_country AS LAND ON FACT.division_id = LAND.division_id AND FACT.country_id = LAND.country_id
   
 LEFT JOIN smp_production_data_shared_kfl.dbp_data_art AS ART ON FACT.art_id_ref = ART.art_id AND FACT.division_id =
      'KFL' AND LAND.division_country_ref = ART.mandant_id AND CAST(FACT.gtin_id AS STRING) = CAST(ART.gtin_id AS STRING)
     AND ART.dat_bis = DATE '9999-12-31'
WHERE FACT.day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 366 DAY) AND (CURRENT_DATE)
 AND FACT.division_id = 'KFL'
 AND FACT.sales_piece_qty > 0
GROUP BY FACT.day_dt,
 FACT.country_id,
 FACT.gtin_id,
 kl_gtin_id,
 art_id_ref,
 art_id_ref_kl;