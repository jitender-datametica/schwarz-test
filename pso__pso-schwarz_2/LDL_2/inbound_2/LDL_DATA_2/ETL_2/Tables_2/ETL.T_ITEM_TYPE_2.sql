CREATE TABLE ETL.T_ITEM_TYPE_2 (
	ITEM_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the subtype discriminator for items.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	ITEM_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for items.',
	CONSTRAINT PK_T_ITEM_TYPE PRIMARY KEY (ITEM_TYPE_CD, LANG_CD)
);
