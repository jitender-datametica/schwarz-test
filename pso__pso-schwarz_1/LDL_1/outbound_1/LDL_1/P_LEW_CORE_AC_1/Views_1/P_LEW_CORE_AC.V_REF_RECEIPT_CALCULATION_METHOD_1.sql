CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_receipt_calculation_method_1 (receipt_calc_method_cd
OPTIONS(description='Code of receipt calculation method for a non personalized discount.'), receipt_calc_method_name
OPTIONS(description='Name of receipt calculation method for a non personalized discount.'), receipt_calc_method_descr
OPTIONS(description='Description of receipt calculation method for a non personalized discount.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table contains the different receipt calculation methodof a non personalized discount.`) AS
SELECT receipt_calc_method_cd,
 receipt_calc_method_name,
 receipt_calc_method_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_receipt_calculation_method_1;