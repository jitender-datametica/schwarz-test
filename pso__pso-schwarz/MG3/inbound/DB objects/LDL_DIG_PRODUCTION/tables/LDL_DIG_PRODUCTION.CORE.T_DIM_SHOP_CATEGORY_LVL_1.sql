create or replace TABLE LDL_DIG_PRODUCTION.CORE.T_DIM_SHOP_CATEGORY_LVL_1 (
	SHOP_CAT_LVL1_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for shop category level 1',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	SHOP_CAT_LVL1_CD NUMBER(38,0) COMMENT 'The code by which the shop category level 1 is known.',
	SHOP_CAT_LVL1_NAME VARCHAR(100) COMMENT 'The name by which the shop category level 1 is known.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SHOP_CATEGORY_LVL_1_GROUP_NAME VARCHAR(40) COMMENT 'The code for the product size type (''Kleines Kleinteil'', ''Großteil''\t, etc)',
	SRC_TABLE_NAME VARCHAR(100) COMMENT 'The name of the source tables',
	constraint PK_T_DIM_SHOP_CATEGORY_LVL_1 primary key (SHOP_CAT_LVL1_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Global shop category - highest level of product hierarchy '
;