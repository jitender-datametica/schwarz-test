CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wfm_export_specification_2 (client_id, country_lidl_cd, export_specification
, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_process.v_wfm_export_specification_2;