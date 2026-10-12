CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_purchase_org_2 (client_id, pur_org_sid, src_ekorg, pur_org_name, comp_sid,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 pur_org_sid,
 src_ekorg,
 pur_org_name,
 comp_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_purchase_org_2;