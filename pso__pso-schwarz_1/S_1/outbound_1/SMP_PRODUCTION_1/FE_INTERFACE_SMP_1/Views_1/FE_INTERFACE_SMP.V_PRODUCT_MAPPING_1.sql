CREATE OR REPLACE VIEW smp_production_fe_interface_smp.v_product_mapping_1 (retailer_id, country_1, article_id, gtins,
multipack_article_id, multipack_quantity, load_timestamp) AS SELECT retailer_id,
 country_id AS country_1,
 article_id,
 ARRAY_AGG(DISTINCT gtin_id) AS gtins,
 CAST(NULL AS STRING) AS multipack_article_id,
 CAST(NULL AS BIGNUMERIC) AS multipack_quantity,
 load_timestamp
FROM smp_production_fe_interface_smp.v_taxonomy_base_1
GROUP BY retailer_id,
 country_1,
 article_id,
 load_timestamp;