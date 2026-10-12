CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_kl_country_gtin_buyer_nonbuyer (day_dt, country_id, art_id_ref
, art_id_ref_kl, gtin_id, buyer) AS SELECT FACT.day_dt,
 FACT.country_id,
 FACT.art_id_ref,
 ART.kl_art_id AS art_id_ref_kl,
 FACT.gtin_id,
 COUNT(DISTINCT FACT.shopper_id_ref) AS buyer
FROM smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day AS FACT
 INNER JOIN smp_production_core_rel.t_country AS LAND ON FACT.division_id = LAND.division_id AND FACT.country_id = LAND
   .country_id
 INNER JOIN smp_production_data_shared_kfl.dbp_data_art AS ART ON FACT.art_id_ref = ART.art_id AND FACT.division_id =
      'KFL' AND LAND.division_country_ref = ART.mandant_id AND CAST(FACT.gtin_id AS STRING) = CAST(ART.gtin_id AS STRING)
     AND ART.dat_bis = DATE '9999-12-31'
WHERE FACT.day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 366 DAY) AND (CURRENT_DATE)
 AND FACT.division_id = 'KFL'
 AND FACT.shopper_id_ref IS NOT NULL
GROUP BY FACT.day_dt,
 FACT.country_id,
 FACT.art_id_ref,
 art_id_ref_kl,
 FACT.gtin_id;