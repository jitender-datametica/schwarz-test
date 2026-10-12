--!SET exit_on_error=True;

-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.


MERGE INTO ldl_data_production_core_rel.t_fruits_and_vegetables_class_1 AS target
USING (SELECT *
  FROM (SELECT c451_class AS fruits_and_vegetables_class_cd,
      'DE' AS lang_cd,
       CASE
       WHEN c451_class = '-'
       THEN 'unbekannt'
       ELSE c451_class
       END AS fruits_and_vegetables_class_descr
     FROM ldl_data_production_etl.t_integra_precore_t451_integra_masterdata_1
     WHERE c451_class IS NOT NULL
     GROUP BY fruits_and_vegetables_class_cd
     UNION DISTINCT
     SELECT c451_class AS fruits_and_vegetables_class_cd,
      'EN' AS lang_cd,
       CASE
       WHEN c451_class = '-'
       THEN 'unknown'
       ELSE c451_class
       END AS fruits_and_vegetables_class_descr
     FROM ldl_data_production_etl.t_integra_precore_t451_integra_masterdata_1
     WHERE c451_class IS NOT NULL
     GROUP BY fruits_and_vegetables_class_cd)
  EXCEPT DISTINCT
  SELECT fruits_and_vegetables_class_cd,
   fruits_and_vegetables_class_descr,
   lang_cd
  FROM ldl_data_production_core_rel.t_fruits_and_vegetables_class_1) AS t9
ON target.fruits_and_vegetables_class_cd = t9.fruits_and_vegetables_class_cd AND target.lang_cd = t9.lang_cd
WHEN MATCHED THEN UPDATE SET
 fruits_and_vegetables_class_descr = t9.fruits_and_vegetables_class_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = CAST(${LOAD_ID} AS INTEGER),
 dwh_node_cd = 'INTERGRA'
WHEN NOT MATCHED THEN INSERT VALUES(t9.fruits_and_vegetables_class_cd, t9.lang_cd, t9.fruits_and_vegetables_class_descr
 , CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), CAST(${LOAD_ID} AS INTEGER), 'INTEGRA');