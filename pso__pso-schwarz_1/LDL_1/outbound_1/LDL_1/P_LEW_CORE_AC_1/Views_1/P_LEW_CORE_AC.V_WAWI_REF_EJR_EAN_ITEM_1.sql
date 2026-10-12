CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_ejr_ean_item_1 (client_id, wh_loc_sid, barcode, orig_item_nr,
gtin_input_cd, case_factor_ejr, load_id, valid_from_dat) AS SELECT client_id,
 wh_loc_sid,
 barcode,
 orig_item_nr,
 gtin_input_cd,
 case_factor_ejr,
 load_id,
 valid_from_dat
FROM ldl_p_lew_core.t_wawi_ref_ejr_ean_item_1;