CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_wawi_itm_ean_2 (client_id, item_sid, dat_rec_start,
dat_rec_end, ean_2, ean_item_desc, custom_nr, custom_key, language_id, load_id) AS SELECT client_id,
 item_sid,
 dat_rec_start,
 dat_rec_end,
 ean_2,
 ean_item_desc,
 custom_nr,
 custom_key,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_ean_2;