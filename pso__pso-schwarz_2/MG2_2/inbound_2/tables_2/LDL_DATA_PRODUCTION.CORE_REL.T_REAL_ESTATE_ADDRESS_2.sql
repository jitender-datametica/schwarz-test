create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_REAL_ESTATE_ADDRESS_2 (
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	ADDR_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the address_2 of the real estate object. This may be a street address_2, a phone number or an email address.',
	ADDR_USG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the way how an address_2 is used. E.g. an address_2 may be used for the customer entrance for a store, and another one for the deliveries.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	ADDR_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminator for addresses.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_REAL_ESTATE_ADDRESS primary key (ADDR_USG_TYPE_CD, ADDR_SID, REAL_ESTATE_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity stores the address_2(es) of a real estate object. An object might have more than one address_2, e.g. an official address_2, the customer entrance and the delivery entrance. The type of address_2 is defined by the address_2 usage type.'
;