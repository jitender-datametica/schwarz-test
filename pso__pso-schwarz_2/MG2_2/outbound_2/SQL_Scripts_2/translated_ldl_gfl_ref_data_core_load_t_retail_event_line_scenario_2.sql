-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.



MERGE INTO ldl_data_production_core_rel.t_retail_event_line_scenario_2 AS target
USING (SELECT retail_event_line_scenario_id,
   lang_cd,
   retail_event_line_scenario_name,
   retail_event_line_scenario_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_retail_event_line_scenario_2
  EXCEPT DISTINCT
  SELECT retail_event_line_scenario_id,
   lang_cd,
   retail_event_line_scenario_name,
   retail_event_line_scenario_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_core_rel.t_retail_event_line_scenario_2) AS t1_2
ON target.retail_event_line_scenario_id = t1.retail_event_line_scenario_id AND target.lang_cd = t1.lang_cd
WHEN MATCHED THEN UPDATE SET
 retail_event_line_scenario_descr = t1.retail_event_line_scenario_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT (retail_event_line_scenario_id, lang_cd, retail_event_line_scenario_name,
 retail_event_line_scenario_descr, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd) VALUES(t1.retail_event_line_scenario_id
 , t1.lang_cd, t1.retail_event_line_scenario_name, t1.retail_event_line_scenario_descr, CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0), 'MANUAL');


commit;