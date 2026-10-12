CREATE TABLE ETL.T_INVENTORY_KEY_TYPE_1 (
	INV_KEY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the type of natural key which identifies the Inventory.',
	INV_KEY_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the type of natural key which identifies the Inventory.',
	INV_KEY_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.'
);