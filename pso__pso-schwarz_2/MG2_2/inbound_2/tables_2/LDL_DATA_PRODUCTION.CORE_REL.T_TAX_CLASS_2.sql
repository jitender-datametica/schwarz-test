create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_TAX_CLASS_2 (
	TAX_CLASS_CD VARCHAR(20) NOT NULL COMMENT 'The code for the tax class, e.g. Reduced VAT Rate.',
	GEO_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the geographical area to which the tax class applies.',
	TAX_CLASS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the tax class.',
	TAX_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of tax. (E.g. VAT)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_TAX_CLASS primary key (TAX_CLASS_CD, GEO_AREA_SID)
)COMMENT='For a given type of tax (e.g. VAT) the tax class defines the percentage. E.g. there is a standard VAT rate and a reduced rate for food. The tax class is specific to a geographical area, typically a country_2, but may also be related to other levels of the geographical hierarchie. E.g. city or county tax in the USA, or a reduced VAT rate which applies to some islands in Greece. The actual percentage value may change over time, therefore it is tracked in a separate entity.'
;