
MERGE INTO ldl_data_production_etl_process.t_wawi_extract_control_status AS sta
USING (WITH src AS (SELECT wawi_instanz_kzl,
     sql_input_wh_nr AS wh_nr,
     MAX(scn) AS scn
    FROM sql_input_schema.sql_input_table
    GROUP BY wawi_instanz_kzl,
     wh_nr) (SELECT t2.wawi_instanz_kzl,
     t2.wh_nr,
     g.ai_graph_name,
     t2.scn
    FROM src AS t2
     INNER JOIN ldl_data_production_etl_process.t_wawi_extract_control_graph AS g ON g.schema_name = 'SQL_INPUT_SCHEMA'
      AND g.table_name = 'SQL_INPUT_TABLE'
    WHERE g.active_fg)) AS src
ON sta.schema_name = 'SQL_INPUT_SCHEMA' AND sta.table_name = 'SQL_INPUT_TABLE' AND src.wawi_instanz_kzl = sta.wawi_instanz_kzl
     AND CAST(src.wh_nr AS FLOAT64) = sta.wh_nr AND src.ai_graph_name = sta.ai_graph_name
WHEN MATCHED THEN UPDATE SET
 max_scn = src.scn,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(sta.${load_id} AS BIGNUMERIC), 0)
WHEN NOT MATCHED THEN INSERT (schema_name, table_name, wawi_instanz_kzl, wh_nr, last_scn, max_scn, dwh_created_tmsp,
 dwh_updated_tmsp, dwh_load_id, ai_graph_name) VALUES('SQL_INPUT_SCHEMA', 'SQL_INPUT_TABLE', src.wawi_instanz_kzl, ROUND(CAST(src.wh_nr AS BIGNUMERIC)
  , 0), 0, src.scn, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ROUND(CAST(sta.${load_id} AS BIGNUMERIC), 0), src.ai_graph_name
 );