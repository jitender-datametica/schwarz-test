CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_company_2 (client_id, comp_sid, src_bukrs, addr_sid, comp_name, city,
account_plan_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 comp_sid,
 src_bukrs,
 addr_sid,
 comp_name,
 city,
 account_plan_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_company_2;