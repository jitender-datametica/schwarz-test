create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_DEPOSIT_ITEM (
	ITEM_GRP_NR VARCHAR(20) NOT NULL COMMENT 'The number by which the international item group is known to business.',
	DEPOSIT_ITEM_NAME VARCHAR(100) COMMENT 'The name by which the deposit item is known.',
	EAN VARCHAR(16777216) COMMENT 'An European article number',
	DEPOSIT_ITEM_CAT_CD VARCHAR(16777216) COMMENT 'The category of the deposit item i.e. refillable, non-refillable',
	RVM_MANUFACTURER_SID NUMBER(38,0),
	LOB_CD VARCHAR(16777216) COMMENT 'The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland\nlob=line os business',
	COUNTRY_POL_CD VARCHAR(16777216) NOT NULL COMMENT 'The code identifying a political country according to ISO 3166.',
	ITEM_CONTENT_CL_QTY VARCHAR(16777216) COMMENT 'The content of an item in cl',
	ITEM_MATERIAL_NAME VARCHAR(100) COMMENT 'The material the item is made of',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	ITEM_REFUND VARCHAR(16777216) COMMENT 'The refund amount of an item',
	constraint PK_T_DIM_DEPOSIT_ITEM primary key (ITEM_GRP_NR)
);