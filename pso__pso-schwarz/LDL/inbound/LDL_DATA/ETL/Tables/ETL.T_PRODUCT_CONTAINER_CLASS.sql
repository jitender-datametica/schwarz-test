CREATE TRANSIENT TABLE ETL.T_PRODUCT_CONTAINER_CLASS (
	PROD_CONTAINER_CLASS_CD VARCHAR(20) NOT NULL COMMENT 'The code distinguishing between module containers and surface containers.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_CONTAINER_CLASS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the product container class.'
)
;