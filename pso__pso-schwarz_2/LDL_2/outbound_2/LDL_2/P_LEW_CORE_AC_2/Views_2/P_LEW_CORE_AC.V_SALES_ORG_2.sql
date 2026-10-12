CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_sales_org_2 (client_id, sales_org_sid, src_vkorg, sales_org_name, comp_sid,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 sales_org_sid,
 src_vkorg,
 sales_org_name,
 comp_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_sales_org_2;