CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_lil_promotion_brand_descr_1 (promotion_brand_id, lang_cd,
promotion_brand_descr, promotion_brand_short_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT promotion_brand_id
 ,
 lang_cd,
 promotion_brand_descr,
 promotion_brand_short_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_lil_promotion_brand_descr_1;