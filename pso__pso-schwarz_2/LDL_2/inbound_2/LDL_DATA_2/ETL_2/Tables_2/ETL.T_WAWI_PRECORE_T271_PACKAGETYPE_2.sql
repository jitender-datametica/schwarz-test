CREATE TABLE ETL.T_WAWI_PRECORE_T271_PACKAGETYPE_2 (
	CTRCODE VARCHAR(3) NOT NULL COLLATE 'en-ci',
	C271_PACKNR NUMBER(5,0) NOT NULL,
	C271_PACKDESCRIPT VARCHAR(15),
	C271_EKS_LINK NUMBER(10,0),
	C271_INT_SHORT VARCHAR(10),
	C271_INT_DESC VARCHAR(15),
	SCN NUMBER(38,0) DEFAULT 0,
	EXTRACTION_TMSP TIMESTAMP_NTZ(9),
	EXTRACTION_DT DATE,
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
);
