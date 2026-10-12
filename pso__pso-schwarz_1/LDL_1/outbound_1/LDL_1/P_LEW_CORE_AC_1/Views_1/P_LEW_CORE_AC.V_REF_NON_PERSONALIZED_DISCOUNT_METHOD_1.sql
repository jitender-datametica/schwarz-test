CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_non_personalized_discount_method_1 (np_discount_method_cd
OPTIONS(description='Code of the calculation method of a non personalized discount for the new price.'),
np_discount_method_name
OPTIONS(description='Nameof the calculation method of a non personalized discount for the new price.'),
np_discount_method_descr
OPTIONS(description='Description of the calculation method of a non personalized discount for the new price.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table contains the different calculation method of a non personalized discount for the new price.`)
AS SELECT np_discount_method_cd,
 np_discount_method_name,
 np_discount_method_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_non_personalized_discount_method_1;