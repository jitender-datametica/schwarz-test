CREATE TABLE CORE.T_DIM_SHOP_CATEGORY (
	SHOP_CAT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for shop category',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	SHOP_CAT_CD NUMBER(38,0) COMMENT 'The unique code by which the shop category is known',
	SHOP_CAT_NAME VARCHAR(250) COMMENT 'The name by which the shop category is known',
	SHOP_CAT_LVL1_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for shop category level 1',
	SHOP_CAT_LVL2_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for shop category level 2',
	SHOP_CAT_LVL3_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for shop category level 3',
	SHOP_CAT_LVL4_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for shop category level 4',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME  VARCHAR(100) COMMENT 'The name of the source tables',
	SHOP_CAT_LVL1_CD                    NUMBER          COMMENT 'The code by which the shop category level 1 is known.',
    SHOP_CAT_LVL2_CD                    NUMBER          COMMENT 'The code by which the shop category level 2 is known.',
    SHOP_CAT_LVL3_CD                    NUMBER          COMMENT 'The code by which the shop category level 3 is known.',
    SHOP_CAT_LVL4_CD                    NUMBER          COMMENT 'The code by which the shop category level 4 is known.',
	CONSTRAINT PK_T_DIM_SHOP_CATEGORY PRIMARY KEY (SHOP_CAT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This table stores the shop category information'
;