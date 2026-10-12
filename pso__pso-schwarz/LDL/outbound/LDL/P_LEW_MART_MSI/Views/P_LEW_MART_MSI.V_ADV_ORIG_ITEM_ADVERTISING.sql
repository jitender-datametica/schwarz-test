CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_adv_orig_item_advertising (client_id, wh_id, orig_item_nr, dat_valid_from,
dat_adv, repeat_fg, currency_iso_cd, rec_src_fg_std, rec_src_fg_apt) AS SELECT *
FROM ldl_p_lew_bil_ac.v_adv_orig_item_advertising AS A;