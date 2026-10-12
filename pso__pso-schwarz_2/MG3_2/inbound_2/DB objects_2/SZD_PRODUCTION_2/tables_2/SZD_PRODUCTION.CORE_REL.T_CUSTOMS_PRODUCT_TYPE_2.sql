create or replace TABLE SZD_PRODUCTION.CORE_REL.T_CUSTOMS_PRODUCT_TYPE_2 (
	CUSTOMS_PRODUCT_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the customs product type.',
	CUSTOMS_PRODUCT_TYPE_DESCR VARCHAR(250) COMMENT 'A brief description of the customs product type.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_CUSTOMS_PRODUCT_TYPE primary key (CUSTOMS_PRODUCT_TYPE_CD)
)COMMENT='Minor Entity - The customs type defines all kinds of possible customs products, like a GTS or WWT customs product. - Source - Manual'
;