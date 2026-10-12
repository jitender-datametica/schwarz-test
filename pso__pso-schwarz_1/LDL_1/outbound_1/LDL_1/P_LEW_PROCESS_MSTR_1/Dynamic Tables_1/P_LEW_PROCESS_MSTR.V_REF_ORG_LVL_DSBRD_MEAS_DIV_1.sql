CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.v_ref_org_lvl_dsbrd_meas_div_1 AS
SELECT MNO.int_id,
 MD.meas_id,
 DML.dsbrd_id,
 DML.phy_doc_id,
 MNO.client_ctry_id,
 MNO.client_id,
 MNO.aspect_id,
 MNO.wh_id,
 MNO.move_to_store_id,
 MNO.org_lvl_id,
 C.curr_tot_id,
 C.currency_iso_cd,
 DML.phy_doc_dsbrd_meas_ord,
 MD.divsr,
 T_TU.text_desc
FROM ldl_p_lew_process_mstr.v_ref_org_lvl_meas_div_act_1 AS MD
 INNER JOIN ldl_p_lew_process_mstr.v_ref_phdoc_dsbrd_meas_rel_act_1 AS DML ON MD.meas_id = DML.meas_id
 INNER JOIN ldl_p_lew_process_mstr.t_agg_nvgtn_org_1 AS MNO ON MNO.org_lvl_id BETWEEN MD.org_lvl_id_from AND MD.org_lvl_id_to
  
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_1 AS C ON MNO.curr_client_id = C.client_id OR MNO.int_id IN (1, 9) AND C
     .currency_iso_cd = 'EUR' AND C.client_id = 23
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_act_1 AS M ON MD.meas_id = M.meas_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_text_act_1 AS T_TU ON MD.unit_text_id = T_TU.text_id
WHERE M.curr_meas_fg = 0
 OR MD.currency_iso_cd = C.currency_iso_cd; 