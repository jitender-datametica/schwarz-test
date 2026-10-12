create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_NON_PERSONALIZED_DISCOUNT_TIME_PERIOD_1(
	CLIENT_ID COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID COMMENT 'Surrogate Key of the non personalized discount.',
	NP_DISCOUNT_ACTION_NR COMMENT 'Unique Identifier of the action for a non-personalized discount.',
	DAY_OF_WEEK COMMENT 'The day of the week on which the non- personalized discount is active within its validity_1 period.',
	NP_DISCOUNT_START_DT COMMENT 'Start date of the non-personalized discount.',
	NP_DISCOUNT_END_DT COMMENT 'End date of the non-personalized discount.',
	NP_DISCOUNT_START_TIME COMMENT 'The start time at which the the non-personalized discount  becomes active within its validity_1 period.',
	NP_DISCOUNT_END_TIME COMMENT 'The end time until which the non-personalized discount  remains active within its validity_1 period.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table defines the validity_1 intervals for non-personalized discount.'
 as 
    SELECT 
        client_id,
        np_discount_sid,
        np_discount_action_nr,
        day_of_week,
        np_discount_start_dt,
        np_discount_end_dt,
        np_discount_start_time,
        np_discount_end_time,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_TIME_PERIOD_1 ;
