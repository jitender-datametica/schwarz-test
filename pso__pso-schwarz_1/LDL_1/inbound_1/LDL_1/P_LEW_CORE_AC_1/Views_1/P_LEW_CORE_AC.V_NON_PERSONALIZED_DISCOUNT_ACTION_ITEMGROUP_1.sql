create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_NON_PERSONALIZED_DISCOUNT_ACTION_ITEMGROUP_1(
	CLIENT_ID COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID COMMENT 'Surrogate Key of the non personalized discount.',
	NP_DISCOUNT_ACTION_NR COMMENT 'Unique Identifier of the action for a non personalized discount.',
	ITEM_GRP_INT_SID COMMENT 'Surrogate Key ITEMGROUP_1 INTERNATIONAL',
	ITEMGROUP_NP_DISCOUNT_METHOD_CD COMMENT 'Code of the calculation method of a non personalized discount for the new itemgroup_1 price.( For action_type_cd = ''MIX_AND_MATCH'' and itemgroup_1 in MatchingItemSet).',
	DISCOUNT_PCT COMMENT 'The percentage discount is deducted from the valid retail price of the itemgroup.( For action_type_cd = ''MIX_AND_MATCH''  and discount_method_cd = ''RP'' and itemgroup_1 in MatchingItemSet).',
	DISCOUNT_VAL COMMENT 'The value is deducted from the itemgroup_1''s current retail price.( For action_type_cd = ''MIX_AND_MATCH'' and discount_method_cd = ''RS_1'' and itemgroup_1 in MatchingItemSet).',
	DISCOUNT_PRICE COMMENT 'This price represents the new price for the itemgroup.( For action_type_cd = ''MIX_AND_MATCH'' and discount_method_cd = ''PS'' and itemgroup_1 in MatchingItemSet ).',
	SET_PRICE_SHARE_PCT COMMENT 'The percentage share assigned to an individual itemgroup_1 within a promotional set price. e.g Promotion offers Itemgroup_1 A and Itemgroup_1 B for a fixed price of 10 €, the percenrage might be set to 70% for Itemgroup_1 A and 30% for Itemgroup_1 B, so 7 € in revenue for Itemgroup_1 A and 3 € for Itemgroup_1 B.(For action_type_cd = ''SET'').',
	CURR_SID COMMENT 'Surrogate Key CURRENCY',
	CURR_CD COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the item_1 group(s) on which the non personalized discount action is applied.'
 as 
    SELECT 
        client_id,
        np_discount_sid,
        np_discount_action_nr,
        item_grp_int_sid,
        itemgroup_np_discount_method_cd,
        discount_pct,
        discount_val,
        discount_price,
        set_price_share_pct,
        curr_sid,
        curr_cd,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_ACTION_ITEMGROUP_1 ;
