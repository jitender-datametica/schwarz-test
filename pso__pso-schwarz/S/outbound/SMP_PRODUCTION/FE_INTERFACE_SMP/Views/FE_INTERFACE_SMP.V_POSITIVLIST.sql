CREATE OR REPLACE VIEW smp_production_fe_interface_smp.v_positivlist (retailer_id, country, gtin, start_date, end_date,
load_timestamp) AS SELECT retailer_id,
 country_id AS country,
 gtin_id AS gtin,
 day_start_dt AS start_date,
 GREATEST(day_end_dt, DATE_ADD(CURRENT_DATE, INTERVAL 56 DAY)) AS end_date,
 load_timestamp
FROM smp_production_fe_interface_smp.v_taxonomy_base;