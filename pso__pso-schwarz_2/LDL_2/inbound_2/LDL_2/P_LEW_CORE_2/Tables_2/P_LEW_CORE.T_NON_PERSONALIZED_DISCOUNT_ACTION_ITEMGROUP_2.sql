create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_ACTION_ITEMGROUP_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key of the non personalized discount.',
	NP_DISCOUNT_ACTION_NR NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the action for a non personalized discount.',
	ITEM_GRP_INT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key ITEMGROUP_2 INTERNATIONAL',
	ITEMGROUP_NP_DISCOUNT_METHOD_CD VARCHAR(100) COMMENT 'Code of the calculation method of a non personalized discount for the new itemgroup_2 price.( For action_type_cd = ''MIX_AND_MATCH'' and itemgroup_2 in MatchingItemSet).',
	DISCOUNT_PCT NUMBER(38,5) COMMENT 'The percentage discount is deducted from the valid retail price of the itemgroup.( For action_type_cd = ''MIX_AND_MATCH''  and discount_method_cd = ''RP'' and itemgroup_2 in MatchingItemSet).',
	DISCOUNT_VAL NUMBER(38,5) COMMENT 'The value is deducted from the itemgroup_2''s current retail price.( For action_type_cd = ''MIX_AND_MATCH'' and discount_method_cd = ''RS_2'' and itemgroup_2 in MatchingItemSet).',
	DISCOUNT_PRICE NUMBER(38,5) COMMENT 'This price represents the new price for the itemgroup.( For action_type_cd = ''MIX_AND_MATCH'' and discount_method_cd = ''PS'' and itemgroup_2 in MatchingItemSet ).',
	SET_PRICE_SHARE_PCT NUMBER(38,5) COMMENT 'The percentage share assigned to an individual itemgroup_2 within a promotional set price. e.g Promotion offers Itemgroup_2 A and Itemgroup_2 B for a fixed price of 10 €, the percenrage might be set to 70% for Itemgroup_2 A and 30% for Itemgroup_2 B, so 7 € in revenue for Itemgroup_2 A and 3 € for Itemgroup_2 B.(For action_type_cd = ''SET'').',
	CURR_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key CURRENCY',
	CURR_CD VARCHAR(100) NOT NULL COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_NON_PERSONALIZED_DISCOUNT_ACTION_ITEMGROUP primary key (NP_DISCOUNT_SID, NP_DISCOUNT_ACTION_NR, ITEM_GRP_INT_SID)
)COMMENT='This table contains the item_2 group(s) on which the non personalized discount action is applied.'
;
