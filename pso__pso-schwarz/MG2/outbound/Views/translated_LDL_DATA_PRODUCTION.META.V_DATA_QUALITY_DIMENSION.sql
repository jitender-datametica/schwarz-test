CREATE OR REPLACE VIEW ldl_data_production_meta.v_data_quality_dimension (dq_dimension_cd
OPTIONS(description='A code identifying the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.'),
dq_dimension_name
OPTIONS(description='The name of the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.'),
dq_dimension_descr OPTIONS(description='The definition of the data quality dimension.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A DATA QUALITY DIMENSION DESCRIBES THE BASIC ASPECTS BY WHICH DATA QUALITY IS MEASURED. E.G. CORRECTNESS, TIMELINESS, COMPLETENESS, CONSISTENCY, ETC.`)
AS SELECT dq_dimension_cd,
 dq_dimension_name,
 dq_dimension_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_data_quality_dimension
UNION DISTINCT
SELECT '@',
 'Unknown dimension',
 'Unknown dimension',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';