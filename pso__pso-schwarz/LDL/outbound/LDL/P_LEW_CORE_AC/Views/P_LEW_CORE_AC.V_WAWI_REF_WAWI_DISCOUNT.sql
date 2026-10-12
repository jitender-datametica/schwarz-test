CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_wawi_discount (client_id, discount_nr_wawi, dat_valid_from,
dat_valid_until, discount_desc, discount_type_id, discount_booking_type_id, dat_last_export, dat_storno, dat_dayend,
load_id) AS SELECT client_id,
 discount_nr_wawi,
 dat_valid_from,
 dat_valid_until,
 discount_desc,
 discount_type_id,
 discount_booking_type_id,
 dat_last_export,
 dat_storno,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_wawi_discount;