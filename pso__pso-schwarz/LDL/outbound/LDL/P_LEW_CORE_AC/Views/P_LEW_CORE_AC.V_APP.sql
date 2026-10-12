CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_app (client_id, app_sid, app_name, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 app_sid,
 app_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_app;