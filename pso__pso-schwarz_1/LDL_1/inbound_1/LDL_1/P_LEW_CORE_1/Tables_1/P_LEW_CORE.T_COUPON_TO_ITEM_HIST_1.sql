create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_COUPON_TO_ITEM_HIST_1 cluster by (
     CLIENT_ID,
     COUPON_SID 
)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice',
	COUPON_SID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the Coupon (surrogate key)',
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the Item_1 that is linked to the coupon (surrogate key)',
	LOYALTY_PROG_CD VARCHAR(5) NOT NULL COLLATE 'en-ci' COMMENT 'identifier of the loyalty program the coupon belongs to',
	COUPON_RELATION_TYPE_CD VARCHAR(6) NOT NULL COLLATE 'en-ci' COMMENT 'code identifying how the item_1 is related to the coupon',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'Mapping is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.',
	DWH_VALID_FROM DATE NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO DATE NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	PARTICIPATING_IN_BENEFIT_FG NUMBER(38,0) COMMENT 'Flag which indicates whether the benefit of the coupon is related to the item_1 or not. Example: If a certain item_1 is purchased, then a benefit for another item_1 will be provided in the coupon. Both items are related to the coupon, but the benefit is related to just one of them.',
	constraint PK_T_COUPON_TO_ITEM_HIST primary key (COUPON_SID, ITEM_SID, COUPON_RELATION_TYPE_CD, DWH_VALID_FROM)
)COMMENT='$Revision: 0000 $. A coupon may be related to one item_1 that the customer can buy for special conditions. A coupon also may be not related to a certain item_1 if the coupon reduces the amount to pay for the whole basket case.'
;
