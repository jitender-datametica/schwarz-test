CREATE TABLE ETL.T_LISTING_TYPE_2 (
	LIST_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	LIST_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc.',
	CONSTRAINT PK_T_LISTING_TYPE PRIMARY KEY (LIST_TYPE_CD, LANG_CD)
);
