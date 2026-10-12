create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE_AC.V_COUPON_TO_ITEM_HIST_2(
	CLIENT_ID COMMENT 'unique identifier of the DWH client / slice',
	COUPON_SID COMMENT 'unique identifier of the Coupon (surrogate key)',
	ITEM_SID COMMENT 'unique identifier of the Item_2 that is linked to the coupon (surrogate key)',
	LOYALTY_PROG_CD COMMENT 'identifier of the loyalty program the coupon belongs to',
	COUPON_RELATION_TYPE_CD COMMENT 'code identifying how the item_2 is related to the coupon',
	PARTICIPATING_IN_BENEFIT_FG COMMENT 'Flag which indicates whether the benefit of the coupon is related to the item_2 or not. Example: If a certain item_2 is purchased, then a benefit for another item_2 will be provided in the coupon. Both items are related to the coupon, but the benefit is related to just one of them.',
	DELETED_FG COMMENT 'Mapping is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.',
	DWH_VALID_FROM COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) as 
    SELECT 
        client_id,
        coupon_sid,
        item_sid,
        loyalty_prog_cd,
        coupon_relation_type_cd,
        participating_in_benefit_fg,
        deleted_fg,
        dwh_valid_from,
        dwh_valid_to,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_COUPON_TO_ITEM_HIST_2 ;
