CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_ref_itm_ean (client_id, loc_sid_wh, wh_id, item_sid, orig_item_nr,
gtin_input_cd, barcode, case_factor_ejr, dwh_valid_from, dwh_valid_to) AS SELECT *
FROM ldl_p_lew_bil.v_ref_itm_ean;