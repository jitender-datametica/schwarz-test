CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_nfpo_organisation_hist (client_id, int_org_sid, display_seq, active_fg,
deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 int_org_sid,
 display_seq,
 active_fg,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_nfpo_organisation_hist;