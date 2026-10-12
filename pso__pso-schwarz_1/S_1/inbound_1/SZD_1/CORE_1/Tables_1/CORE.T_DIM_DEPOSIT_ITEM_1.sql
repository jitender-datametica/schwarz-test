CREATE TABLE CORE.T_DIM_DEPOSIT_ITEM_1 (
	ITEM_GRP_NR VARCHAR(20) NOT NULL COMMENT 'The number by which the international item_1 group is known to business.',
	DEPOSIT_ITEM_NAME VARCHAR(100) COMMENT 'The name by which the deposit item_1 is known.',
	EAN_1 VARCHAR(16777216) COMMENT 'An European article number',
	DEPOSIT_ITEM_CAT_CD VARCHAR(16777216) COMMENT 'The category of the deposit item_1 i.e. refillable, non-refillable',
	RVM_MANUFACTURER_SID NUMBER(38,0),
	LOB_CD VARCHAR(16777216) COMMENT 'The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland
lob=line os business',
	COUNTRY_POL_CD VARCHAR(16777216) NOT NULL COMMENT 'The code identifying a political country_1 according to ISO 3166.',
	ITEM_CONTENT_CL_QTY VARCHAR(16777216) COMMENT 'The content of an item_1 in cl',
	ITEM_MATERIAL_NAME VARCHAR(100) COMMENT 'The material the item_1 is made of',
	Item_refund VARCHAR(16777216) COMMENT 'The refund amount of an item_1',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_DEPOSIT_ITEM PRIMARY KEY (ITEM_GRP_NR)
)COMMENT='Deposit items, i.e. items for which a deposit is charged and which customers are supposed to bring back to the store. E.g. empty bottles.'
;