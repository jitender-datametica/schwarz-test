CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_pinfo_header_2 (client_id, pinfo_sid, src_infnr, sup_sid, item_sid,
sap_creation_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 pinfo_sid,
 src_infnr,
 sup_sid,
 item_sid,
 sap_creation_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_pinfo_header_2;