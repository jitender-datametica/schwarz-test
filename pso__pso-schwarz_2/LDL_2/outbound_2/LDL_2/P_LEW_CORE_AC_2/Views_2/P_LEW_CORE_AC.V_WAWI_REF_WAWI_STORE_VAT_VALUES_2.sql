CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_wawi_store_vat_values_2 (client_id, st_loc_sid, vat_id, country_cd,
dat_rec_start, store_vat_id, pct_vat, store_pct_vat, dat_rec_end, dat_modification, dat_dayend, load_id) AS SELECT
 client_id,
 st_loc_sid,
 vat_id,
 country_cd,
 dat_rec_start,
 store_vat_id,
 pct_vat,
 store_pct_vat,
 dat_rec_end,
 dat_modification,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_wawi_store_vat_values_2;