CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_country_chlog (country_id, dashboard_relevant_fg, requesting_user,
timestamp_request, approval_fg, approval_user, timestamp_approval) AS SELECT country_id,
 dashboard_relevant_fg,
 requesting_user,
 timestamp_request,
 approval_fg,
 approval_user,
 timestamp_approval
FROM ldl_p_lew_core.t_wawi_ref_country_chlog;