create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_NON_PERSONALIZED_DISCOUNT_BOOKING_TYPE(
	NP_DISCOUNT_BOOKING_TYPE_ID COMMENT 'Code for the price change reason of  the non personalized discount.',
	NP_DISCOUNT_BOOKING_TYPE_NAME COMMENT 'Name for the price change reason of the non personalized discount.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the different booking type of a non personalized discount.'
 as 
    SELECT 
        np_discount_booking_type_id,
        np_discount_booking_type_name,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_NON_PERSONALIZED_DISCOUNT_BOOKING_TYPE ;
