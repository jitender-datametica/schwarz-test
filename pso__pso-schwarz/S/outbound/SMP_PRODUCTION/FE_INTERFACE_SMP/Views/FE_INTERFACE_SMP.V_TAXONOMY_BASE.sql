CREATE OR REPLACE VIEW smp_production_fe_interface_smp.v_taxonomy_base (division_id, country_id, gtin_id, article_id,
article_parent_id, article_name, day_start_dt, day_end_dt, taxonomy_attributes, retailer_id, load_timestamp) AS SELECT
 division_id,
 country_id,
 gtin_id,
 article_id,
 article_parent_id,
 article_name,
 day_start_dt,
 day_end_dt,
 taxonomy_attributes,
 retailer_id,
 load_timestamp
FROM (SELECT division_id,
   country_id,
   gtin_id,
   COALESCE(article_parent_id, article_id) AS article_id,
   article_parent_id,
   COALESCE(article_name, article_name_country) AS article_name,
   MIN(day_start_dt) OVER (PARTITION BY division_id, country_id, gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS day_start_dt,
   MAX(day_end_dt) OVER (PARTITION BY division_id, country_id, gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS day_end_dt,
   taxonomy_attributes,
   retailer_id,
   MAX(load_timestamp) OVER (PARTITION BY retailer_id, country_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS load_timestamp,
   COUNT(gtin_id) OVER (PARTITION BY retailer_id, country_id, COALESCE(article_parent_id, article_id) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz
  FROM (SELECT *
     FROM smp_production_fe_interface_smp.t_smp_taxonomy_base
     UNION ALL
     SELECT *
     FROM smp_production_etl_process.t_smp_taxonomy_base_exception
     WHERE (division_id, country_id, gtin_id) NOT IN (SELECT (division_id, country_id, gtin_id)
        FROM smp_production_fe_interface_smp.t_smp_taxonomy_base
        WHERE gtin_id IS NOT NULL)) AS b) AS t3
QUALIFY (ROW_NUMBER() OVER (PARTITION BY retailer_id, country_id, gtin_id ORDER BY anz NULLS LAST, article_id NULLS LAST
      , article_name NULLS LAST, TO_JSON_STRING(taxonomy_attributes) DESC NULLS FIRST)) = 1;