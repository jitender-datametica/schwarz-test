create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_INVENTORY_TYPE (
	INV_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for inventorys.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	INV_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for inventorys.'
)COMMENT='This minor entity defines the subtye discriminators for inventorys. It distinguishes between full inventories and partial inventories.'
;