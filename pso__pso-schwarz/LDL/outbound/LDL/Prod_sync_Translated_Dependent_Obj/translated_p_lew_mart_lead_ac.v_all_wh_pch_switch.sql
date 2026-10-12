CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_all_wh_pch_switch (client_id, wh_id, aspect_id, pch_bnl_switch_fg,
switch_date, dwh_updated) OPTIONS(DESCRIPTION = `Steering Table for all wh incl. VGES`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_all_wh_pch_switch AS V;