!SET exit_on_error=True;

-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.
MERGE INTO core_rel.t_fruits_and_vegetables_class_1 AS target USING 
 (
  SELECT 
    c451_class as fruits_and_vegetables_class_cd,
    'DE' as lang_cd,
    CASE WHEN c451_class = '-' THEN 'unbekannt' ELSE c451_class end AS fruits_and_vegetables_class_descr    
  FROM etl.t_integra_precore_t451_integra_masterdata_1 
  WHERE  c451_class IS NOT NULL
  GROUP BY c451_class
  UNION
  SELECT 
    c451_class AS fruits_and_vegetables_class_cd,
    'EN' AS lang_cd,
    CASE WHEN c451_class = '-' THEN 'unknown' ELSE c451_class end AS fruits_and_vegetables_class_descr
  FROM etl.t_integra_precore_t451_integra_masterdata_1 
  WHERE c451_class IS NOT NULL
  GROUP BY c451_class
  MINUS 
  SELECT 
    fruits_and_vegetables_class_cd, 
    fruits_and_vegetables_class_descr, 
    lang_cd    
  FROM core_rel.t_fruits_and_vegetables_class_1 
 ) AS source ON target.fruits_and_vegetables_class_cd = source.fruits_and_vegetables_class_cd 
                AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.fruits_and_vegetables_class_descr = source.fruits_and_vegetables_class_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'INTERGRA' 
WHEN NOT matched THEN 
INSERT (
    fruits_and_vegetables_class_cd, 
    lang_cd, 
    fruits_and_vegetables_class_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.fruits_and_vegetables_class_cd, 
    source.lang_cd, 
    source.fruits_and_vegetables_class_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'INTEGRA'
  );
