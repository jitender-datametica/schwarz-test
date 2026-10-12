
/*Manually create the aggregation control records here, rther than the generated protocol sql.
We need to to do this because the generated protocol-sql uses for hist tables calendar_2 date instead of date_field here inv_dt.
In order to benefit from the delta load we do it with post sql.
*/




MERGE INTO ldl_data_production_etl_process.t_prcs_delta_2 AS prcs_delta
USING (SELECT DISTINCT dwh_node_cd,
  country_org_cd AS country_cd,
  inv_dt AS dwh_cal_dt,
  COALESCE(int_org_sid, - 1) AS loc_sid,
   (SELECT dependency
   FROM ldl_data_production_etl_process.t_prcs_main_2
   WHERE dependency = 't_wawi_inventory_result_2'
   GROUP BY dependency) AS dependency
 FROM ldl_data_production_etl.${src2tgt_temp_table2}_${src_context_area}
 WHERE error_fg = 0
  AND (SELECT dependency
   FROM ldl_data_production_etl_process.t_prcs_main_2
   WHERE dependency = 't_wawi_inventory_result_2'
   GROUP BY dependency) IS NOT NULL
  AND country_org_cd IS NOT NULL
  AND inv_dt IS NOT NULL) AS POC
ON prcs_delta.dwh_node_cd = POC.dwh_node_cd AND prcs_delta.country_cd = POC.country_cd AND prcs_delta.dwh_cal_dt = POC.dwh_cal_dt
     AND prcs_delta.dependency = POC.dependency AND prcs_delta.loc_sid = POC.loc_sid
WHEN MATCHED THEN UPDATE SET
 load_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST('${LOAD_ID}' AS BIGNUMERIC), 0)
WHEN NOT MATCHED THEN INSERT VALUES(POC.dependency, POC.dwh_node_cd, POC.country_cd, POC.dwh_cal_dt, POC.loc_sid,
 CURRENT_TIMESTAMP(), ROUND(CAST('${LOAD_ID}' AS BIGNUMERIC), 0));


UPDATE ldl_data_production_etl_process.t_wawi_extract_control_status_2 SET
 last_scn = t_wawi_extract_control_status.max_scn,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = t_wawi_extract_control_status.${load_id}
WHERE schema_name = UPPER('whwawiadm') AND table_name = UPPER('t180_stinventory_2') AND ai_graph_name =
  '${AI_GRAPH_NAME}';


UPDATE ldl_data_production_etl_process.t_wawi_extract_control_status_2 SET
 last_scn = t_wawi_extract_control_status.max_scn,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = t_wawi_extract_control_status.${load_id}
WHERE schema_name = UPPER('whwawiadm') AND table_name = UPPER('t182_sic_inventory_2') AND ai_graph_name =
  '${AI_GRAPH_NAME}';