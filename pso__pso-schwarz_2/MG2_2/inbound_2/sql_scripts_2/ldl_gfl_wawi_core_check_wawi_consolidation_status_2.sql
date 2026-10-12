 WITH e AS
(
  SELECT 'WHWAWIADM' AS schema, table_name, MIN(updated_tmsp) AS updated_tmsp
  FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.wawi_consolidation_extract_log_2 l
  JOIN etl_process.t_wawi_extract_control_zone_2 c ON l.wawi_instanz_kzl=c.country_2
  WHERE zone_seq=${ZONE_TO_CHECK}
  GROUP BY 1,2
  UNION ALL
  SELECT 'HQWAWIADM' AS schema, table_name, MIN(updated_tmsp) AS updated_tmsp
  FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.wawi_consolidation_extract_log_2 l
  JOIN etl_process.t_wawi_extract_control_zone_2 c ON l.wawi_instanz_kzl=c.country_2
  WHERE zone_seq=${ZONE_TO_CHECK}
  GROUP BY 1,2
  UNION ALL
  SELECT 'WHWAWISTD' AS schema, table_name, MIN(updated_tmsp) AS updated_tmsp
  FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.wawi_consolidation_extract_log_2 l
  JOIN etl_process.t_wawi_extract_control_zone_2 c ON l.wawi_instanz_kzl=c.country_2
  WHERE zone_seq=${ZONE_TO_CHECK}
  GROUP BY 1,2
  UNION ALL
  SELECT 'HQWAWISTD' AS schema, table_name, MIN(updated_tmsp) AS updated_tmsp
  FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.wawi_consolidation_extract_log_2 l
  JOIN etl_process.t_wawi_extract_control_zone_2 c ON l.wawi_instanz_kzl=c.country_2
  WHERE zone_seq=${ZONE_TO_CHECK}
  GROUP BY 1,2
)
SELECT IFF(MIN(updated_tmsp)>=CURRENT_DATE,1,0) AS status_2
FROM ETL_PROCESS.T_WAWI_EXTRACT_CONTROL_2 c
JOIN e ON  c.table_name=e.table_name AND e.schema=c.schema_name AND c.ACTIVE_FG;
