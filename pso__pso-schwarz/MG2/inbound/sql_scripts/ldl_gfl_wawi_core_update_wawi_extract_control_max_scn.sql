MERGE INTO etl_process.t_wawi_extract_control_status sta
USING 
  (
    WITH src AS
      (
       SELECT wawi_instanz_kzl,SQL_INPUT_WH_NR AS wh_nr,MAX(scn) AS scn
       FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.SQL_INPUT_SCHEMA.SQL_INPUT_TABLE
       GROUP BY wawi_instanz_kzl,wh_nr
      ) 
    SELECT src.wawi_instanz_kzl,src.wh_nr,g.ai_graph_name,src.scn
    FROM src 
    JOIN etl_process.t_wawi_extract_control_graph g ON g.schema_name = 'SQL_INPUT_SCHEMA' AND g.table_name = 'SQL_INPUT_TABLE' 
    WHERE g.active_fg
   ) src
ON schema_name =  'SQL_INPUT_SCHEMA' AND table_name = 'SQL_INPUT_TABLE' AND src.wawi_instanz_kzl=sta.wawi_instanz_kzl AND src.wh_nr=sta.wh_nr AND src.ai_graph_name=sta.ai_graph_name
WHEN MATCHED THEN
  UPDATE SET max_scn = src.scn, dwh_updated_tmsp = CURRENT_TIMESTAMP, dwh_load_id = ${LOAD_ID}
WHEN NOT MATCHED THEN
  INSERT  
    (schema_name,
     table_name,
     wawi_instanz_kzl,
     wh_nr,
     ai_graph_name, 
     last_scn,
     max_scn,
     dwh_created_tmsp,
     dwh_updated_tmsp,
     dwh_load_id
    )
  VALUES 
    ('SQL_INPUT_SCHEMA',
     'SQL_INPUT_TABLE',
     wawi_instanz_kzl,
     src.wh_nr,
     src.ai_graph_name,
     0,
     src.scn,
     CURRENT_TIMESTAMP,
     CURRENT_TIMESTAMP,
     ${LOAD_ID}
    )      
;
