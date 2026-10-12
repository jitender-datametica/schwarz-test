create or replace view LDL_DATA_PRODUCTION.META.V_DATA_QUALITY_DIMENSION(
	DQ_DIMENSION_CD COMMENT 'A code identifying the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.',
	DQ_DIMENSION_NAME COMMENT 'The name of the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.',
	DQ_DIMENSION_DESCR COMMENT 'The definition of the data quality dimension.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A data quality dimension describes the basic aspects by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.'
 as
SELECT
   dq_dimension_cd
  ,dq_dimension_name
  ,dq_dimension_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_DATA_QUALITY_DIMENSION
UNION
SELECT '@', 'Unknown dimension', 'Unknown dimension', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;