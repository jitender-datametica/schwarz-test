create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_NON_PERSONALIZED_DISCOUNT_HIST(
	CLIENT_ID COMMENT 'unique identifier of the DWH client / slice',
	NP_DISCOUNT_SID COMMENT 'Foreign Key for t_non_personalized_discount',
	NP_DISCOUNT_STATUS_CD COMMENT 'Status of the non personalized discount.',
	NP_DISCOUNT_START_DT COMMENT 'Start date of the non personalized discount.',
	NP_DISCOUNT_END_DT COMMENT 'End date of the non personalized discount.',
	NP_DISCOUNT_BOOKING_TYPE_ID COMMENT 'Price change reason (analogous to ERP price change reasons) to be used for the discount.',
	NP_DISCOUNT_DESCR COMMENT 'Description of the non personalized discount.',
	RECEIPT_NP_DISCOUNT_NAME COMMENT 'Name to be displayed in the discount line on the receipt.',
	PREV_NP_DISCOUNT_SID COMMENT 'Surrogate Key of the predecessor of a non personalized discount.',
	DELETED_FG COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1',
	DWH_VALID_FROM COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the non personalised discount (historised version).'
 as 
    SELECT 
        client_id,
        np_discount_sid,
        np_discount_status_cd,
        np_discount_start_dt,
        np_discount_end_dt,
        np_discount_booking_type_id,
        np_discount_descr,
        receipt_np_discount_name,
        prev_np_discount_sid,
        deleted_fg,
        dwh_valid_from,
        dwh_valid_to,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_HIST ;
