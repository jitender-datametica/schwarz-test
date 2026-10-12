CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_sales_org_descr_1 (client_id, sales_org_sid, lang_sid, lang_cd, sales_org_descr
, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 sales_org_sid,
 lang_sid,
 lang_cd,
 sales_org_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_sales_org_descr_1;