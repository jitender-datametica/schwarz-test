CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_application_2 (application_id, application_desc, application_desc_en) AS
SELECT application_id,
 application_desc,
 application_desc_en
FROM ldl_p_lew_mart_cm.t_lil_application_2;