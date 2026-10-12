create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_TRANSPORT_TYPE_1 (
	TRANSPORT_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Natural Key/Business Key - Type of transport that is used deliver the goods from harbor EU to OWIM warehouse',
	TRANSPORT_ROUTE_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Natural Key/Business Key - Type of transport that is used deliver the goods from harbor EU to OWIM warehouse',
	WHOLESALE_CD VARCHAR(50) COMMENT 'The code of the transport mode and transport route typ used in the \"Wholesale\" solution.',
	WHOLESALE_LABEL_DESCR VARCHAR(250) COMMENT 'A brief description of the transport mode and transport route typ used in the \"Wholesale\" solution.',
	FOREIGNTRADE_ID NUMBER(38,0) COMMENT 'The code of the transport mode and transport route typ used in the \"Foreign Trade\" solution.',
	FOREIGNTRADE_LABEL_DESCR VARCHAR(250) COMMENT 'A brief description of the transport mode and transport route typ used in the \"Foreign Trade\" solution.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_DIM_TRANSPORT_TYPE primary key (TRANSPORT_TYPE_CD, TRANSPORT_ROUTE_TYPE_CD)
)COMMENT='Minor Dimension - Type of transport that is used deliver the goods.\n             Wholesale uses route types BEFORE_IMPORT for it''s international transportation and AFTER_IMPORT for domestic transport at importing country.\n             Foreign trade uses route type BEFORE_IMPORT only for transportation to the importing country. - Source - VMT'
;