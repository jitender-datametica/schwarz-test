CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_org_lvl_dsbrd_meas_div_2 (int_id, meas_id, dsbrd_id, phy_doc_id,
client_ctry_id, client_id, aspect_id, wh_id, move_to_store_id, org_lvl_id, curr_tot_id, currency_iso_cd,
phy_doc_dsbrd_meas_ord, divsr, unit_text_desc) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_org_lvl_dsbrd_meas_div_2;