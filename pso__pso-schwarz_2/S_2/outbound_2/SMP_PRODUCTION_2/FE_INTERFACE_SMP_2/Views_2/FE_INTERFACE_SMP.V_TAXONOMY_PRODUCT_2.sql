
CREATE OR REPLACE VIEW smp_production_fe_interface_smp.v_taxonomy_product_2 (retailer_id, country_2, gtin, gtin_name,
list_attributes, load_timestamp) AS SELECT retailer_id,
 country_id AS country_2,
 gtin_id AS gtin,
 article_name AS gtin_name,
 taxonomy_attributes AS list_attributes,
 load_timestamp
FROM smp_production_fe_interface_smp.v_taxonomy_base_2;