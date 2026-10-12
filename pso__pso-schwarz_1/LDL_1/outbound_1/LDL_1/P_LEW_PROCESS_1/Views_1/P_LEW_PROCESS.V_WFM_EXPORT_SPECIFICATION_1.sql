CREATE OR REPLACE VIEW ldl_p_lew_process.v_wfm_export_specification_1 (client_id, country_lidl_cd, export_specification,
dwh_created, dwh_updated) AS SELECT client_id,
 country_lidl_cd,
 export_specification,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process.t_wfm_export_specification_1 AS V;