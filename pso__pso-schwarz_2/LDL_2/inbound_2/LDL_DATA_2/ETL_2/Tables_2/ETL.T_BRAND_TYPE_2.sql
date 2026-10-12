CREATE TABLE ETL.T_BRAND_TYPE_2 (
	BRAND_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of a brand. It distinguishes between own brands and other retailer brands.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	BRAND_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of a brand.',
	CONSTRAINT PK_T_BRAND_TYPE PRIMARY KEY (BRAND_TYPE_CD, LANG_CD)
);
