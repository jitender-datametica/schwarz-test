CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_lil_promotion_brand_1 (promotion_brand_id, promotion_brand_descr,
liam1_srt_cd, lift1_srt_cd, active_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT promotion_brand_id,
 promotion_brand_descr,
 liam1_srt_cd,
 lift1_srt_cd,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_lil_promotion_brand_1;