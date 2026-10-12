CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_kl_country_gtin_buyer_nonbuyer_bkp_1 (day_dt, country_id,
art_id_ref, art_id_ref_kl, gtin_id, cnt_shopper_tot, buyer, nonbuyer) AS SELECT TOT.day_dt,
 TOT.country_id,
 TOT_GTIN.art_id_ref,
 TOT_GTIN.art_id_ref_kl,
 TOT_GTIN.gtin_id,
 TOT.cnt_shopper_tot,
 TOT_GTIN.cnt_shopper AS buyer,
  TOT.cnt_shopper_tot - TOT_GTIN.cnt_shopper AS nonbuyer
FROM (SELECT day_dt,
   country_id,
   COUNT(DISTINCT shopper_id_ref) AS cnt_shopper_tot
  FROM smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day_1 AS FACT
  WHERE day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 366 DAY) AND (CURRENT_DATE)
   AND division_id = 'KFL'
   AND shopper_id_ref IS NOT NULL
  GROUP BY day_dt,
   country_id) AS TOT
 INNER JOIN (SELECT FACT0.day_dt,
   FACT0.country_id,
   FACT0.art_id_ref,
   ART.kl_art_id AS art_id_ref_kl,
   FACT0.gtin_id,
   COUNT(DISTINCT FACT0.shopper_id_ref) AS cnt_shopper
  FROM smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day_1 AS FACT0
   INNER JOIN smp_production_core_rel.t_country_1 AS LAND_1 ON FACT0.division_id = LAND.division_id AND FACT0.country_id =
     LAND.country_id
   INNER JOIN smp_production_data_shared_kfl.dbp_data_art_1 AS ART_1 ON FACT0.art_id_ref = ART.art_id AND FACT0.division_id
        = 'KFL' AND LAND.division_country_ref = ART.mandant_id AND CAST(FACT0.gtin_id AS STRING) = CAST(ART.gtin_id AS STRING)
       AND ART.dat_bis = DATE '9999-12-31'
  WHERE FACT0.day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 366 DAY) AND (CURRENT_DATE)
   AND FACT0.division_id = 'KFL'
   AND FACT0.shopper_id_ref IS NOT NULL
  GROUP BY FACT0.day_dt,
   FACT0.country_id,
   FACT0.art_id_ref,
   art_id_ref_kl,
   FACT0.gtin_id) AS TOT_GTIN ON TOT.day_dt = TOT_GTIN.day_dt AND TOT.country_id = TOT_GTIN.country_id;