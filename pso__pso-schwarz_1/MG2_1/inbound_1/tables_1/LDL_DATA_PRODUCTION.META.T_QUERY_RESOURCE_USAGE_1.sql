create or replace TABLE LDL_DATA_PRODUCTION.META.T_QUERY_RESOURCE_USAGE_1 (
	QUERY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the query.',
	QUERY_RESOURCE_USG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the type of resource which is consumed by the execution of a query. E.g. CPU, I/O, disk, ...',
	QUERY_RESOURCE_USG_MEAS NUMBER(38,5) NOT NULL COMMENT 'The amount of the resource which was used by the query.',
	UOM_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the unit_1 of measure.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_QUERY_RESOURCE_USAGE primary key (QUERY_SID, QUERY_RESOURCE_USG_TYPE_CD)
)COMMENT='This measure entity tracks the resource consumption of a query. The type of resource (e.g. CPU, I/O, disk, ...) is defined by the Query Resource Type.'
;