CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_main_pillar (main_pillar_cd, main_pillar_name, dwh_load_id, dwh_created,
dwh_updated) AS SELECT main_pillar_cd,
 main_pillar_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_main_pillar;