create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_TRIGGER_ITEM (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key of the non personalized discount.',
	NP_DISCOUNT_TRIGGER_NR NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the trigger for a non-personalized discount.',
	NP_DISCOUNT_ACTION_NR NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the action for a non-personalized discount.',
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg).',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_NON_PERSONALIZED_DISCOUNT_TRIGGER_ITEM primary key (NP_DISCOUNT_SID, NP_DISCOUNT_TRIGGER_NR, NP_DISCOUNT_ACTION_NR, ITEM_SID)
)COMMENT='This table contains the item(s) required to trigger the non personalized discount, which may differ from the item(s) to which the discount is applied.'
;
