CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_rel_article_gtin_1 (country_id, gtin_id, art_id_ref, art_id_ref_kl) AS
SELECT country_id,
 gtin_id,
 art_id_ref,
 art_id_ref_kl
FROM smp_production_fe_mstr_smp.v_fact_sales_store_supplier_shopper_gtin_day_1 AS FACT
WHERE day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 366 DAY) AND (CURRENT_DATE)
 AND division_id = 'KFL'
 AND sales_piece_qty > 0
 AND shopper_id_ref IS NOT NULL;