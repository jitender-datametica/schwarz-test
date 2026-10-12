CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_promotion_domain_2 (orig_promotion_domain_nr,
orig_promotion_domain_sh_desc, orig_promotion_domain_desc, dat_rec_start, dat_rec_end, timestamp_load) AS SELECT
 orig_promotion_domain_nr,
 orig_promotion_domain_sh_desc,
 orig_promotion_domain_desc,
 dat_rec_start,
 dat_rec_end,
 timestamp_load
FROM ldl_p_lew_core.t_wawi_ref_promotion_domain_2;