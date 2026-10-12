create or replace TABLE SMP_PRODUCTION.CORE_REL.T_SHOPPER (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country iso code',
	SHOPPER_ID VARCHAR(100) NOT NULL COMMENT 'SMP Shopper reference',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job',
	SHOPPER_ID_REF VARIANT NOT NULL COMMENT 'Division shopper reference, e.g. customer_sid, Kundenkarte_id, KFL sometimes more than one',
	ACTIVE_FG NUMBER(38,0) NOT NULL COMMENT 'Flag active/inactve Shopper',
	HOME_STORE_ID VARCHAR(100) COMMENT 'Shopper Favorite Store/Homestore',
	HOME_ZIP_CODE VARCHAR(100) COMMENT 'Shopper Zip Code (based on Favourite Store/Homestore',
	GENDER_ID VARCHAR(100) COMMENT 'Shoppper Gender: male, femaile, diverse, unknown',
	AGE NUMBER(38,0) COMMENT 'Age of Shopper'
)COMMENT='Shopper masterdata'
;
