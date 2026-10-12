create or replace TABLE SZD_PRODUCTION.CORE_REL.T_TRANSPORT_TYPE_2 (
	TRANSPORT_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique identifier of the transport mode.',
	TRANSPORT_ROUTE_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the transport route type.',
	TRANSPORT_TYPE_DESCR VARCHAR(250) COMMENT 'A brief description of the transport mode.',
	WHOLESALE_CD VARCHAR(50) COMMENT 'The code of the transport mode and transport route typ used in the \"Wholesale\" solution.',
	WHOLESALE_LABEL_DESCR VARCHAR(250) COMMENT 'A brief description of the transport mode and transport route typ used in the \"Wholesale\" solution.',
	FOREIGNTRADE_ID VARCHAR(50) COMMENT 'The code of the transport mode and transport route typ used in the \"Foreign Trade\" solution.',
	FOREIGNTRADE_LABEL_DESCR VARCHAR(250) COMMENT 'A brief description of the transport mode and transport route typ used in the \"Foreign Trade\" solution.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_TRANSPORT_TYPE primary key (TRANSPORT_TYPE_CD, TRANSPORT_ROUTE_TYPE_CD)
)COMMENT='Minor Entity - Indicates the way in which means of transport are used to transport goods.\n             Wholesale uses route types BEFORE_IMPORT for its international transportation and AFTER_IMPORT for domestic transport at importing country.\n             Foreign trade uses route type BEFORE_IMPORT only for transportation to the importing country. - Source - Manual'
;