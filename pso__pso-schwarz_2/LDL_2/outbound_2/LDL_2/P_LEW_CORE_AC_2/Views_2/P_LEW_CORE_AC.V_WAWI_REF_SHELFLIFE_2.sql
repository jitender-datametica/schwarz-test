CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_shelflife_2 (client_id, shelflife_id, shelflife_short_desc,
shelflife_desc, language_id, dat_rec_start, dat_rec_end, factor_period, load_id) AS SELECT client_id,
 shelflife_id,
 shelflife_short_desc,
 shelflife_desc,
 language_id,
 dat_rec_start,
 dat_rec_end,
 factor_period,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_shelflife_2;