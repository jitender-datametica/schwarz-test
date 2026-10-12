create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PARTY_ADDRESS (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party.',
	ADDR_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the address.',
	ADDR_USG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the way how an address is used. E.g. an address may be used for the customer entrance for a store, and another one for the deliveries.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PARTY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminator for parties.',
	ADDR_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminator for addresses.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PARTY_ADDRESS primary key (ADDR_USG_TYPE_CD, ADDR_SID, PARTY_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity stores the address(es) of a party. A party might have more than one address, e.g. an official street address, a primary telephone number or one or several mobile phone number. The type of address is defined by the address usage type.'
;