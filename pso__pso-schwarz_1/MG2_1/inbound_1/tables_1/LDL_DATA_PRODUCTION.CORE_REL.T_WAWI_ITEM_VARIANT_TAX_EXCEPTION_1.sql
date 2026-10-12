create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_WAWI_ITEM_VARIANT_TAX_EXCEPTION_1 (
	WAWI_ITEM_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item_1 variant.',
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization to which non-standard taxation rules apply.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	GEO_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the geographical area to which the tax class applies.',
	TAX_CLASS_CD VARCHAR(20) NOT NULL COMMENT 'The code for the tax class, e.g. Reduced VAT Rate.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_WAWI_ITEM_VARIANT_TAX_EXCEPTION primary key (WAWI_ITEM_VARIANT_SID, INT_ORG_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Different tax rules may apply to specific internal organizations, e.g. because a store is located in a tax enclave. In this case a different VAT rate applies. This entity lists all internal organizations together with their related tax classes, which deviate from the standard taxation rules defined in the Wawi Item_1 Variant Tax entity.'
;