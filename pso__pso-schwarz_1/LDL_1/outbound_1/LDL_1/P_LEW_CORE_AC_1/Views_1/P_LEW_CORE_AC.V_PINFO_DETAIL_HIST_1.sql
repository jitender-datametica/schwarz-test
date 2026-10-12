CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_pinfo_detail_hist_1 (client_id, pinfo_sid, loc_sid, pur_org_sid, brand_sid,
pinfo_type_cd, incoterm_1, incoterm_2, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated)
AS SELECT client_id,
 pinfo_sid,
 loc_sid,
 pur_org_sid,
 brand_sid,
 pinfo_type_cd,
 incoterm_1,
 incoterm_2,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_pinfo_detail_hist_1;