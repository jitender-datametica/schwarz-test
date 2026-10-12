-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.
MERGE INTO core_rel.t_technical_cash_register_event_type_2 AS target USING (
  SELECT 
    tech_cash_register_event_type_cd, 
    lang_cd, 
    tech_cash_register_event_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    etl.t_technical_cash_register_event_type_2
  MINUS 
  SELECT 
    tech_cash_register_event_type_cd, 
    lang_cd, 
    tech_cash_register_event_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    core_rel.t_technical_cash_register_event_type_2
) AS source ON target.tech_cash_register_event_type_cd = source.tech_cash_register_event_type_cd 
AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.tech_cash_register_event_type_descr = source.tech_cash_register_event_type_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    tech_cash_register_event_type_cd, 
    lang_cd, 
    tech_cash_register_event_type_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.tech_cash_register_event_type_cd, 
    source.lang_cd, 
    source.tech_cash_register_event_type_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );

commit;

