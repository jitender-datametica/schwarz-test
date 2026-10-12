CREATE TRANSIENT TABLE ETL.T_PRODUCT_CONTAINER_SIZE (
	PROD_CONTAINER_SIZE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the size class for module containers. (small / medium / large)',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_CONTAINER_SIZE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the size class for module containers.'
)
;