create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PALLET_TYPE (
	PALLET_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of pallet. (Euro-pallet vs. Duesseldorfer pallet)',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PALLET_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of pallet.',
	PALLET_SPACE_FACTOR NUMBER(38,5) COMMENT 'The ratio of the floor space consumed by this palett type compared with the floor space of a Euro palett. E.g. 0,5 für a Duesseldorfer palett.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PALLET_TYPE primary key (PALLET_TYPE_CD, LANG_CD)
)COMMENT='This minor entity defines the various types of pallets, E.g. Euro-pallets and Duesseldorfer pallets.'
;