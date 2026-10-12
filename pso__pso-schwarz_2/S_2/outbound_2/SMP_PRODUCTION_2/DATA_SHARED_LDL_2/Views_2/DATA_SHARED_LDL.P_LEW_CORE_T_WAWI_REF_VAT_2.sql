CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_wawi_ref_vat_2 (client_id, vat_id, dat_rec_start,
dat_rec_end, vat_desc, pct_vat, language_id, load_id) AS SELECT client_id,
 vat_id,
 dat_rec_start,
 dat_rec_end,
 vat_desc,
 pct_vat,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_vat_2;