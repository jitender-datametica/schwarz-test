CREATE OR REPLACE TEMPORARY TABLE vt3 AS
SELECT AGG.bus_dt,
 AGG.country_org_cd,
 AGG.int_org_sid,
 AGG.int_org_type_cd,
 AGG.curr_cd,
 AGG.write_off_net_val,
 AGG.write_off_for_breakage_net_val,
 AGG.write_off_for_sell_by_dt_net_val,
 AGG.write_off_for_deliv_quality_net_val,
 AGG.write_off_for_defective_non_food_net_val,
 AGG.write_off_for_donations_net_val,
 AGG.write_off_for_discounts_net_val,
 AGG.write_off_for_taken_prod_net_val,
 AGG.write_off_for_force_majeure_net_val,
 AGG.write_off_for_stock_clearance_net_val,
 CURRENT_TIMESTAMP() AS dwh_created_tmsp,
 CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
 '${LOAD_ID}' AS dwh_load_id,
 'CORE_REL' AS dwh_node_cd
FROM (SELECT bus_dt,
   country_org_cd,
   int_org_sid,
   int_org_type_cd,
   curr_cd,
   SUM(CASE
     WHEN write_off_reason_id IN (2, 128)
     THEN write_off_net_val
     ELSE 0
     END) AS write_off_for_breakage_net_val,
   SUM(CASE
     WHEN write_off_reason_id IN (2, 128)
     THEN write_off_net_val
     ELSE 0
     END) AS write_off_for_sell_by_dt_net_val,
   SUM(CASE
     WHEN write_off_reason_id IN (2, 128)
     THEN write_off_net_val
     ELSE 0
     END) AS write_off_for_deliv_quality_net_val,
   SUM(CASE
     WHEN write_off_reason_id IN (2, 128)
     THEN write_off_net_val
     ELSE 0
     END) AS write_off_for_defective_non_food_net_val,
   SUM(CASE
     WHEN write_off_reason_id IN (2, 128)
     THEN write_off_net_val
     ELSE 0
     END) AS write_off_for_donations_net_val,
   SUM(CASE
     WHEN write_off_reason_id IN (2, 128)
     THEN write_off_net_val
     ELSE 0
     END) AS write_off_for_discounts_net_val,
   SUM(CASE
     WHEN write_off_reason_id IN (2, 128)
     THEN write_off_net_val
     ELSE 0
     END) AS write_off_for_taken_prod_net_val,
   SUM(CASE
     WHEN write_off_reason_id IN (2, 128)
     THEN write_off_net_val
     ELSE 0
     END) AS write_off_for_force_majeure_net_val,
   SUM(CASE
     WHEN write_off_reason_id IN (2, 128)
     THEN write_off_net_val
     ELSE 0
     END) AS write_off_for_stock_clearance_net_val,
   SUM(write_off_net_val) AS write_off_net_val
  FROM ldl_data_production_core_rel.t_write_off_event_1 AS wr
  WHERE curr_stat_fg
   AND int_org_type_cd = 'STORE'
   AND write_off_event_type_id IN (137, 147)
  GROUP BY bus_dt,
   country_org_cd,
   int_org_sid,
   int_org_type_cd,
   curr_cd) AS AGG
 LEFT JOIN ldl_data_production_core_dim.t_fact_retail_by_store_day_1 AS sa ON AGG.bus_dt = sa.bus_dt AND AGG.country_org_cd
       = sa.country_org_cd AND AGG.int_org_sid = sa.int_org_sid AND AGG.int_org_type_cd = sa.int_org_type_cd AND AGG.curr_cd
    = sa.curr_cd;


BEGIN TRANSACTION
;


TRUNCATE TABLE ldl_data_production_etl_process.t_tcache_write_off_by_organization_day_1;


INSERT INTO ldl_data_production_etl_process.t_tcache_write_off_by_organization_day_1 (int_org_sid, int_org_type_cd,
 country_org_cd, bus_dt, curr_cd, write_off_net_val, write_off_for_breakage_net_val, write_off_for_sell_by_dt_net_val,
 write_off_for_deliv_quality_net_val, write_off_for_defective_non_food_net_val, write_off_for_donations_net_val,
 write_off_for_discounts_net_val, write_off_for_taken_prod_net_val, write_off_for_force_majeure_net_val,
 write_off_for_stock_clearance_net_val, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
(SELECT int_org_sid,
  int_org_type_cd,
  country_org_cd,
  bus_dt,
  curr_cd,
  write_off_net_val,
  write_off_for_breakage_net_val,
  write_off_for_sell_by_dt_net_val,
  write_off_for_deliv_quality_net_val,
  write_off_for_defective_non_food_net_val,
  write_off_for_donations_net_val,
  write_off_for_discounts_net_val,
  write_off_for_taken_prod_net_val,
  write_off_for_force_majeure_net_val,
  write_off_for_stock_clearance_net_val,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
 FROM vt3);


COMMIT
;