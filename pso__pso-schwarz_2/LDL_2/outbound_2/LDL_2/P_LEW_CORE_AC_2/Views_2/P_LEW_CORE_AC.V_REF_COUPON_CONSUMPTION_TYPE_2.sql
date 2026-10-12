CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_coupon_consumption_type_2 (coupon_consumption_type_cd
OPTIONS(description='Code for the coupon\'s usage of a non-personalized discount.'), coupon_consumption_type_name
OPTIONS(description='Name for coupon\'s usage of a non.personalized discount.'), coupon_consumption_type_descr
OPTIONS(description='Description for coupon\'s usage of a non-personalized discount.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table contains the different coupon''s usage of a non-personalized discount.`) AS SELECT
 coupon_consumption_type_cd,
 coupon_consumption_type_name,
 coupon_consumption_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_coupon_consumption_type_2;