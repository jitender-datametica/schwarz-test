CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_pillar_1 (pillar_id, main_pillar_id, pillar_name, dwh_created, dwh_updated)
AS SELECT *
FROM ldl_p_lew_process_mstr_ac.v_pillar_1;