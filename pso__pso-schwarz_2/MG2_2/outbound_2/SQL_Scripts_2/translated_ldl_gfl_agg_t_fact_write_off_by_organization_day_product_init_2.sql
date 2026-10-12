CREATE OR REPLACE TEMPORARY TABLE vt3 AS
SELECT agg.bus_dt,
 agg.int_org_sid,
 agg.int_org_type_cd,
 COALESCE(prdvar.prod_sid, - 1) AS prod_sid,
 agg.logistic_variant_sid,
 agg.country_org_sid,
 agg.country_org_cd,
  agg.write_off_for_breakage_net_val * - 1 AS write_off_for_breakage_net_val,
  agg.write_off_for_sell_by_dt_net_val * - 1 AS write_off_for_sell_by_dt_net_val,
  agg.write_off_for_deliv_quality_net_val * - 1 AS write_off_for_deliv_quality_net_val,
  agg.write_off_for_defective_non_food_net_val * - 1 AS write_off_for_defective_non_food_net_val,
  agg.write_off_for_donations_net_val * - 1 AS write_off_for_donations_net_val,
  agg.write_off_for_taken_prod_net_val * - 1 AS write_off_for_taken_prod_net_val,
  agg.write_off_for_discounts_net_val * - 1 AS write_off_for_discounts_net_val,
  agg.write_off_net_val * - 1 AS write_off_net_val,
  agg.write_off_for_force_majeure_net_val * - 1 AS write_off_for_force_majeure_net_val,
  agg.write_off_for_stock_clearance_net_val * - 1 AS write_off_for_stock_clearance_net_val,
 agg.curr_cd,
 CURRENT_TIMESTAMP() AS dwh_created_tmsp,
 CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
 '${LOAD_ID}' AS dwh_load_id,
 'CORE_REL' AS dwh_node_cd
FROM (SELECT bus_dt,
   int_org_sid,
   'STORE' AS int_org_type_cd,
   logistic_variant_sid,
   country_org_sid,
   country_org_cd,
   write_off_for_breakage_net_val,
   write_off_for_breakage_net_val AS write_off_for_sell_by_dt_net_val,
   write_off_for_breakage_net_val AS write_off_for_deliv_quality_net_val,
   write_off_for_breakage_net_val AS write_off_for_defective_non_food_net_val,
   write_off_for_breakage_net_val AS write_off_for_donations_net_val,
   write_off_for_breakage_net_val AS write_off_for_taken_prod_net_val,
   write_off_for_breakage_net_val AS write_off_for_discounts_net_val,
   write_off_net_val,
   write_off_for_breakage_net_val AS write_off_for_force_majeure_net_val,
   write_off_for_breakage_net_val AS write_off_for_stock_clearance_net_val,
   curr_cd_0 AS curr_cd
  FROM (SELECT bus_dt,
     int_org_sid,
     logistic_variant_sid,
     curr_cd,
     ANY_VALUE(country_org_sid) AS country_org_sid,
     ANY_VALUE(country_org_cd) AS country_org_cd,
     SUM(CASE
       WHEN write_off_reason_id IN (2, 128)
       THEN write_off_net_val
       ELSE 0
       END) AS write_off_for_breakage_net_val,
     SUM(CASE
       WHEN write_off_reason_id IN (1, 127, 134, 135)
       THEN write_off_net_val
       ELSE 0
       END) AS write_off_for_sell_by_dt_net_val,
     SUM(CASE
       WHEN write_off_reason_id IN (8)
       THEN write_off_net_val
       ELSE 0
       END) AS write_off_for_deliv_quality_net_val,
     SUM(CASE
       WHEN write_off_reason_id IN (9, 10, 11)
       THEN write_off_net_val
       ELSE 0
       END) AS write_off_for_defective_non_food_net_val,
     SUM(CASE
       WHEN write_off_reason_id IN (7, 130, 131)
       THEN write_off_net_val
       ELSE 0
       END) AS write_off_for_donations_net_val,
     SUM(CASE
       WHEN write_off_reason_id IN (4, 101, 102, 110, 111, 129, 155)
       THEN write_off_net_val
       ELSE 0
       END) AS write_off_for_taken_prod_net_val,
     SUM(CASE
       WHEN write_off_reason_id IN (5)
       THEN write_off_net_val
       ELSE 0
       END) AS write_off_for_discounts_net_val,
     SUM(write_off_net_val) AS write_off_net_val,
     SUM(CASE
       WHEN write_off_reason_id IN (3, 136, 137, 152)
       THEN write_off_net_val
       ELSE 0
       END) AS write_off_for_force_majeure_net_val,
     SUM(CASE
       WHEN write_off_reason_id IN (6, 151)
       THEN write_off_net_val
       ELSE 0
       END) AS write_off_for_stock_clearance_net_val,
     ANY_VALUE(COALESCE(curr_cd, '@')) AS curr_cd_0
    FROM ldl_data_production_core_rel.t_write_off_event_2 AS wr
    WHERE curr_stat_fg
     AND int_org_type_cd = 'STORE'
     AND write_off_event_type_id IN (137, 147)
    GROUP BY bus_dt,
     int_org_sid,
     logistic_variant_sid,
     curr_cd) AS t1_2) AS agg
 LEFT JOIN ldl_data_production_core_rel.t_product_variant_2 AS prdvar ON agg.logistic_variant_sid = prdvar.prod_variant_sid
    AND prdvar.dwh_valid_fg;


BEGIN TRANSACTION;


TRUNCATE TABLE ldl_data_production_core_dim.t_fact_write_off_by_organization_day_product_2;


INSERT INTO ldl_data_production_core_dim.t_fact_write_off_by_organization_day_product_2 (bus_dt, int_org_sid,
 int_org_type_cd, prod_sid, logistic_variant_sid, country_org_sid, country_org_cd, write_off_for_breakage_net_val,
 write_off_for_sell_by_dt_net_val, write_off_for_deliv_quality_net_val, write_off_for_defective_non_food_net_val,
 write_off_for_donations_net_val, write_off_for_taken_prod_net_val, write_off_for_discounts_net_val, curr_cd,
 dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd, write_off_net_val, write_off_for_force_majeure_net_val,
 write_off_for_stock_clearance_net_val)
(SELECT DISTINCT bus_dt,
  int_org_sid,
  int_org_type_cd,
  prod_sid,
  logistic_variant_sid,
  country_org_sid,
  country_org_cd,
  write_off_for_breakage_net_val,
  write_off_for_sell_by_dt_net_val,
  write_off_for_deliv_quality_net_val,
  write_off_for_defective_non_food_net_val,
  write_off_for_donations_net_val,
  write_off_for_taken_prod_net_val,
  write_off_for_discounts_net_val,
  curr_cd,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd,
  write_off_net_val,
  write_off_for_force_majeure_net_val,
  write_off_for_stock_clearance_net_val
 FROM (SELECT bus_dt,
    int_org_sid,
    int_org_type_cd,
    prod_sid,
    logistic_variant_sid,
    country_org_sid,
    country_org_cd,
    write_off_for_breakage_net_val,
    write_off_for_sell_by_dt_net_val,
    write_off_for_deliv_quality_net_val,
    write_off_for_defective_non_food_net_val,
    write_off_for_donations_net_val,
    write_off_for_taken_prod_net_val,
    write_off_for_discounts_net_val,
    curr_cd,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd,
    write_off_net_val,
    write_off_for_force_majeure_net_val,
    write_off_for_stock_clearance_net_val
   FROM vt3) AS t
 WHERE NOT EXISTS (SELECT 1 AS `A12180`
   FROM ldl_data_production_core_dim.t_fact_write_off_by_organization_day_product_2
   WHERE bus_dt = t.bus_dt
    AND int_org_sid = t.int_org_sid
    AND logistic_variant_sid = t.logistic_variant_sid)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY bus_dt, int_org_sid, logistic_variant_sid)) = 1);


COMMIT;