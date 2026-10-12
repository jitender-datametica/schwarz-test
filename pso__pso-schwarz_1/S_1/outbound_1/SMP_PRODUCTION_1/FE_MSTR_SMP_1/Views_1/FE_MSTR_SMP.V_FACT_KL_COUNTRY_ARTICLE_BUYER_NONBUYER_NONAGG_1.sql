CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_kl_country_article_buyer_nonbuyer_nonagg_1 (day_dt, country_id,
art_id_ref_kl, buyer) AS SELECT DISTINCT FACT.day_dt,
 FACT.country_id,
 ART.kl_art_id AS art_id_ref_kl,
 FACT.shopper_id_ref AS buyer
FROM smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day_1 AS FACT
 LEFT JOIN smp_production_data_shared_kfl.dbp_data_art_1 AS ART_1 ON FACT.art_id_ref = ART.art_id AND ART.dat_bis =
   DATE '9999-12-31'
WHERE FACT.day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND (CURRENT_DATE)
 AND FACT.division_id = 'KFL'
 AND FACT.shopper_id_ref IS NOT NULL;