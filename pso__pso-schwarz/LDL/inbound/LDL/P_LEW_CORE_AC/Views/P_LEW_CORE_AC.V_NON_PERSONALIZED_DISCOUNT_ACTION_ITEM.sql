create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_NON_PERSONALIZED_DISCOUNT_ACTION_ITEM(
	CLIENT_ID COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID COMMENT 'Surrogate Key of the non personalized discount.',
	NP_DISCOUNT_ACTION_NR COMMENT 'Unique Identifier of the action for a non personalized discount.',
	ITEM_SID COMMENT 'Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg).',
	ITEM_NP_DISCOUNT_METHOD_CD COMMENT 'Code of the calculation method of a non personalized discount for the new item price.( For action_type_cd = ''MIX_AND_MATCH'' and item in MatchingItemSet).',
	DISCOUNT_PCT COMMENT 'The percentage discount is deducted from the valid retail price of the item.( For action_type_cd = ''MIX_AND_MATCH''  and discount_method_cd = ''RP'' and item in MatchingItemSet).',
	DISCOUNT_VAL COMMENT 'The value is deducted from the item''s current retail price.( For action_type_cd = ''MIX_AND_MATCH'' and discount_method_cd = ''RS'' and item in MatchingItemSet).',
	DISCOUNT_PRICE COMMENT 'This price represents the new price for the item.( For action_type_cd = ''MIX_AND_MATCH'' and discount_method_cd = ''PS'' and item in MatchingItemSet ).',
	SET_PRICE_SHARE_PCT COMMENT 'The percentage share assigned to an individual item within a promotional set price. e.g Promotion offers Item A and Item B for a fixed price of 10 €, the percenrage might be set to 70% for Item A and 30% for Item B, so 7 € in revenue for Item A and 3 € for Item B.(For action_type_cd = ''SET'').',
	CURR_SID COMMENT 'Surrogate Key CURRENCY',
	CURR_CD COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the item(s) on which the non personalized discount action is applied.'
 as 
    SELECT 
        client_id,
        np_discount_sid,
        np_discount_action_nr,
        item_sid,
        item_np_discount_method_cd,
        discount_pct,
        discount_val,
        discount_price,
        set_price_share_pct,
        curr_sid,
        curr_cd,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_ACTION_ITEM ;
