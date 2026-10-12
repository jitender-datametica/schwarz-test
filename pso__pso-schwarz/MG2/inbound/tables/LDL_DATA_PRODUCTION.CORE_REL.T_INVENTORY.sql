create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_INVENTORY (
	INV_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the inventory event.',
	INV_DT DATE NOT NULL COMMENT 'The date when the inventory is carried out.',
	INV_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for inventorys.',
	INV_NR NUMBER(38,0) NOT NULL COMMENT 'The number which identifies the inventory event in a given country.',
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization for which the inventory is done.',
	INT_ORG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country organization.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
	INV_PERIOD_START_DT DATE COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.',
	INV_PERIOD_END_DT DATE COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	INV_REASON_ID NUMBER(38,0) COMMENT 'The identifier for the reason why an inventory was initiated.',
	constraint PK_T_INVENTORY primary key (INV_SID)
)COMMENT='An inventory event is the process of counting the number of products that are on stock in a given store or warehouse (delivery company). The result of an inventory may correct the calculated stock.'
;