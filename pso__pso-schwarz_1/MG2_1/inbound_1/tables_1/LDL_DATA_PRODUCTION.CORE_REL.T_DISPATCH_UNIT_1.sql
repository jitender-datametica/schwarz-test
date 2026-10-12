create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_DISPATCH_UNIT_1 (
	DISPATCH_UNIT_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the unit_1 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	DISPATCH_UNIT_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the unit_1 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DISPATCH_UNIT primary key (DISPATCH_UNIT_CD, LANG_CD)
)COMMENT='The dispatch unit_1 defines the unit_1 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc.'
;