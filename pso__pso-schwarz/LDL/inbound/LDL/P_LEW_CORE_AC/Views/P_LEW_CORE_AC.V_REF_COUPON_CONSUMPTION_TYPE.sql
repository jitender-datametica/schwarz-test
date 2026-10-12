create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_COUPON_CONSUMPTION_TYPE(
	COUPON_CONSUMPTION_TYPE_CD COMMENT 'Code for the coupon''s usage of a non-personalized discount.',
	COUPON_CONSUMPTION_TYPE_NAME COMMENT 'Name for coupon''s usage of a non.personalized discount.',
	COUPON_CONSUMPTION_TYPE_DESCR COMMENT 'Description for coupon''s usage of a non-personalized discount.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the different coupon''s usage of a non-personalized discount.'
 as 
    SELECT 
        coupon_consumption_type_cd,
        coupon_consumption_type_name,
        coupon_consumption_type_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_COUPON_CONSUMPTION_TYPE ;
