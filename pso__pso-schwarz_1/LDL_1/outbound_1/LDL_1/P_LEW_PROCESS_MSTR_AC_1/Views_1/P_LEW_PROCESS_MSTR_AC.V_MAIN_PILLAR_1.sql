CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_main_pillar_1 (main_pillar_id, main_pillar_name, dwh_created,
dwh_updated) AS SELECT main_pillar_id,
 main_pillar_name,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_main_pillar_1 AS V;