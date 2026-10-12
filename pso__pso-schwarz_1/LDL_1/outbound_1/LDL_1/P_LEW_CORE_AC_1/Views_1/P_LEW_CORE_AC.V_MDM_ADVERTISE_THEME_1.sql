CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_advertise_theme_1 (client_id, mdm_ad_theme_sid, src_proj_doc_ref,
ad_theme_name, ad_theme_cd, ad_theme_id, busyear_ad_theme, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_ad_theme_sid,
 src_proj_doc_ref,
 ad_theme_name,
 ad_theme_cd,
 ad_theme_id,
 busyear_ad_theme,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_advertise_theme_1;