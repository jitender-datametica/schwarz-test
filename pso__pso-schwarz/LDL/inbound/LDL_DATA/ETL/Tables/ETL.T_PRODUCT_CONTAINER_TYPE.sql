CREATE TRANSIENT TABLE ETL.T_PRODUCT_CONTAINER_TYPE (
	PROD_CONTAINER_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for product containers.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_CONTAINER_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for product containers.'
);