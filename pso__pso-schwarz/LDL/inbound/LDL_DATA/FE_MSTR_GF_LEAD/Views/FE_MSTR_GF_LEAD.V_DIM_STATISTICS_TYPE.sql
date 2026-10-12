CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_STATISTICS_TYPE(
	STAT_TYPE_CD COMMENT 'The code identifying the kind of metric which is calculated for internal companies.',
	STAT_TYPE_DESCR COMMENT 'A textual description for the kind of metric which is calculated for internal companies.',
	DWH_UPDATED_TMSP COMMENT 'the point in time when this record was created or last updated.',
	DWH_NODE_CD COMMENT 'the code for the source system (or slice of source system) from which this record was loaded.',
	DWH_CREATED_TMSP COMMENT 'the point in time when this record was created in the data warehouse.',
	DWH_LOAD_ID COMMENT 'the unique identifier of the batch load which has done the last update to this record.'
) COMMENT='This minor entity defines the kind of metric which is calculated for internal companies.'
 AS
SELECT 
main.stat_type_cd AS stat_type_cd
,main.stat_type_descr AS stat_type_descr
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_node_cd AS dwh_node_cd
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_load_id AS dwh_load_id
FROM CORE_REL.T_STATISTICS_TYPE main
WHERE main.lang_cd = 'DE';