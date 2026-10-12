create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_NON_PERSONALIZED_DISCOUNT_TRIGGER_ITEM_1(
	CLIENT_ID COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID COMMENT 'Surrogate Key of the non personalized discount.',
	NP_DISCOUNT_TRIGGER_NR COMMENT 'Unique Identifier of the trigger for a non-personalized discount.',
	NP_DISCOUNT_ACTION_NR COMMENT 'Unique Identifier of the action for a non-personalized discount.',
	ITEM_SID COMMENT 'Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg).',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the item_1(s) required to trigger the non personalized discount, which may differ from the item_1(s) to which the discount is applied.'
 as 
    SELECT 
        client_id,
        np_discount_sid,
        np_discount_trigger_nr,
        np_discount_action_nr,
        item_sid,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_TRIGGER_ITEM_1 ;
