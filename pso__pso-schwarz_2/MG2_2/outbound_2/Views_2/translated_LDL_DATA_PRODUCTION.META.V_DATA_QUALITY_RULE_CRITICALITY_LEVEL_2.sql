CREATE OR REPLACE VIEW ldl_data_production_meta.v_data_quality_rule_criticality_level_2 (dq_rule_criticality_lvl_cd
OPTIONS(description='The code identifying the criticality level for a data quality rule. E.g. high, medium, low.'),
dq_rule_criticality_lvl_descr
OPTIONS(description='A textual description for the criticality level for a data quality rule. E.g. high, medium, low.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE CRITICALITY LEVEL FOR A DATA QUALITY RULE. E.G. HIGH, MEDIUM, LOW.`)
AS SELECT dq_rule_criticality_lvl_cd,
 dq_rule_criticality_lvl_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_data_quality_rule_criticality_level_2
UNION DISTINCT
SELECT '@',
 'Unknown criticality',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';