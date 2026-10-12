-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.



MERGE INTO ldl_data_production_core_rel.t_revenue_statistics_type_1 AS target
USING (SELECT revenue_stat_type_id,
   lang_cd,
   revenue_stat_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_revenue_statistics_type_1
  EXCEPT DISTINCT
  SELECT revenue_stat_type_id,
   lang_cd,
   revenue_stat_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_core_rel.t_revenue_statistics_type_1) AS t1_1
ON target.revenue_stat_type_id = t1.revenue_stat_type_id AND target.lang_cd = t1.lang_cd
WHEN MATCHED THEN UPDATE SET
 revenue_stat_type_descr = t1.revenue_stat_type_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT VALUES(t1.revenue_stat_type_id, t1.lang_cd, t1.revenue_stat_type_descr, CURRENT_TIMESTAMP()
 , CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0), 'MANUAL');


commit;