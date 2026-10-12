CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_pillar_2 (pillar_id, main_pillar_id, pillar_name, dwh_created,
dwh_updated) AS SELECT pillar_id,
 main_pillar_id,
 pillar_name,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_pillar_2 AS V;