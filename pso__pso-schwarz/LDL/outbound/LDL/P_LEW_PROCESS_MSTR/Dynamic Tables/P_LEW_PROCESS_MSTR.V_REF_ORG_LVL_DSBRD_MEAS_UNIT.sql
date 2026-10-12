CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.v_ref_org_lvl_dsbrd_meas_unit AS
/* p_lew_process_mstr.v_agg_dsbrd_meas_pg_nvgtn */ 
SELECT MNO.int_id,
 MD.meas_id,
 dml.dsbrd_id,
 dml.phy_doc_type_id,
 MNO.client_ctry_id,
 MNO.client_id,
 MNO.aspect_id,
 MNO.wh_id,
 MNO.move_to_store_id,
 MNO.org_lvl_id,
 C.curr_tot_id,
 C.currency_iso_cd,
 dml.blk_meas_ord,
 dml.pg_no,
 dml.pg_meas_ord,
 dml.dsbrd_meas_ord AS phy_doc_dsbrd_meas_ord,
 MD.divsr,
 T_TU.text_desc
FROM ldl_p_lew_process_mstr.v_ref_org_lvl_meas_div_act AS MD
 INNER JOIN (SELECT dsbrd_id,
   phy_doc_type_id,
   pg_no,
   meas_id,
   blk_meas_ord,
   dsbrd_meas_ord,
   pg_meas_ord
  FROM ldl_p_lew_process_mstr.t_agg_dsbrd_meas_pg_nvgtn
  GROUP BY dsbrd_id,
   phy_doc_type_id,
   blk_meas_ord,
   meas_id,
   dsbrd_meas_ord,
   pg_meas_ord,
   pg_no) AS dml ON MD.meas_id = dml.meas_id
 INNER JOIN ldl_p_lew_process_mstr.t_agg_nvgtn_org AS MNO ON MNO.org_lvl_id BETWEEN MD.org_lvl_id_from AND MD.org_lvl_id_to
  
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS C ON MNO.curr_client_id = C.client_id OR MNO.int_id IN (1, 9) AND C
     .currency_iso_cd = 'EUR' AND C.client_id = 2
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_act AS M ON MD.meas_id = M.meas_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_text_act AS T_TU ON MD.unit_text_id = T_TU.text_id
WHERE M.curr_meas_fg = 0
 OR MD.currency_iso_cd = C.currency_iso_cd;