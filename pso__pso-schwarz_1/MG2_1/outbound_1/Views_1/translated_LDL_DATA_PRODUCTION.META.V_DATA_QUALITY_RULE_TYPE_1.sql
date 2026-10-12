CREATE OR REPLACE VIEW ldl_data_production_meta.v_data_quality_rule_type_1 (dq_rule_type_cd
OPTIONS(description='A code for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.'),
dq_rule_type_descr
OPTIONS(description='A textual description for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE SUBTYPE DISCRIMINATORS FOR DATA QUALITY RULES. IT DISTINGUISHES BETWEEN BUSINESS RULES, GENERATED AND PARAMETRIZED RULES.`)
AS SELECT dq_rule_type_cd,
 dq_rule_type_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_data_quality_rule_type_1
UNION DISTINCT
SELECT '@',
 'Unknown rule type',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';