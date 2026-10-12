create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_ACTION_ITEM (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key of the non personalized discount.',
	NP_DISCOUNT_ACTION_NR NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the action for a non personalized discount.',
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg).',
	ITEM_NP_DISCOUNT_METHOD_CD VARCHAR(100) COMMENT 'Code of the calculation method of a non personalized discount for the new item price.( For action_type_cd = ''MIX_AND_MATCH'' and item in MatchingItemSet).',
	DISCOUNT_PCT NUMBER(38,5) COMMENT 'The percentage discount is deducted from the valid retail price of the item.( For action_type_cd = ''MIX_AND_MATCH''  and discount_method_cd = ''RP'' and item in MatchingItemSet).',
	DISCOUNT_VAL NUMBER(38,5) COMMENT 'The value is deducted from the item''s current retail price.( For action_type_cd = ''MIX_AND_MATCH'' and discount_method_cd = ''RS'' and item in MatchingItemSet).',
	DISCOUNT_PRICE NUMBER(38,5) COMMENT 'This price represents the new price for the item.( For action_type_cd = ''MIX_AND_MATCH'' and discount_method_cd = ''PS'' and item in MatchingItemSet ).',
	SET_PRICE_SHARE_PCT NUMBER(38,5) COMMENT 'The percentage share assigned to an individual item within a promotional set price. e.g Promotion offers Item A and Item B for a fixed price of 10 €, the percenrage might be set to 70% for Item A and 30% for Item B, so 7 € in revenue for Item A and 3 € for Item B.(For action_type_cd = ''SET'').',
	CURR_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key CURRENCY',
	CURR_CD VARCHAR(100) NOT NULL COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_NON_PERSONALIZED_DISCOUNT_ACTION_ITEM primary key (NP_DISCOUNT_SID, NP_DISCOUNT_ACTION_NR, ITEM_SID)
)COMMENT='This table contains the item(s) on which the non personalized discount action is applied.'
;
