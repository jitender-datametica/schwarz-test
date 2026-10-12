CREATE TABLE ETL.T_INVENTORY_STATISTICS_TYPE (
	INV_STAT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of stasticis value that is calculated for an inventory.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	INV_STAT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of stasticis value that is calculated for an inventory.'
);