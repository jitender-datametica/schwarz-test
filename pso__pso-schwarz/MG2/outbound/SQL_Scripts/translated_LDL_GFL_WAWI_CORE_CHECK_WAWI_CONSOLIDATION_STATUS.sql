WITH e AS (SELECT 'WHWAWIADM' AS schema,
    l.table_name,
    MIN(l.updated_tmsp) AS updated_tmsp
   FROM ldl_wawi_production_whwawiadm.wawi_consolidation_extract_log AS l
    INNER JOIN ldl_data_production_etl_process.t_wawi_extract_control_zone AS c ON l.wawi_instanz_kzl = c.country
   WHERE c.zone_seq = CAST(${ZONE_TO_CHECK} AS FLOAT64)
   GROUP BY schema,
    l.table_name
   UNION ALL
   SELECT 'HQWAWIADM' AS schema,
    l.table_name,
    MIN(l.updated_tmsp) AS updated_tmsp
   FROM ldl_wawi_production_hqwawiadm.wawi_consolidation_extract_log AS l
    INNER JOIN ldl_data_production_etl_process.t_wawi_extract_control_zone AS c ON l.wawi_instanz_kzl = c.country
   WHERE c.zone_seq = CAST(${ZONE_TO_CHECK} AS FLOAT64)
   GROUP BY schema,
    l.table_name
   UNION ALL
   SELECT 'WHWAWISTD' AS schema,
    l.table_name,
    MIN(l.updated_tmsp) AS updated_tmsp
   FROM ldl_wawi_production_whwawiadm.wawi_consolidation_extract_log AS l
    INNER JOIN ldl_data_production_etl_process.t_wawi_extract_control_zone AS c ON l.wawi_instanz_kzl = c.country
   WHERE c.zone_seq = CAST(${ZONE_TO_CHECK} AS FLOAT64)
   GROUP BY schema,
    l.table_name
   UNION ALL
   SELECT 'HQWAWISTD' AS schema,
    l.table_name,
    MIN(l.updated_tmsp) AS updated_tmsp
   FROM ldl_wawi_production_hqwawiadm.wawi_consolidation_extract_log AS l
    INNER JOIN ldl_data_production_etl_process.t_wawi_extract_control_zone AS c ON l.wawi_instanz_kzl = c.country
   WHERE c.zone_seq = CAST(${ZONE_TO_CHECK} AS FLOAT64)
   GROUP BY schema,
    l.table_name) (SELECT IF(SAFE_CAST(MIN(t12.updated_tmsp) as DATE) >= CURRENT_DATE, 1, 0) AS status
  FROM ldl_data_production_etl_process.t_wawi_extract_control AS c
   INNER JOIN e AS t12 ON c.table_name = t12.table_name AND c.schema_name = t12.schema AND c.active_fg);