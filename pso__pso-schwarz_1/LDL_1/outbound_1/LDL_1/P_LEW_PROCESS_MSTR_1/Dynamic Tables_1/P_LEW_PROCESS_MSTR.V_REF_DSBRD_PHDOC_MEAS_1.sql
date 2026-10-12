CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.v_ref_dsbrd_phdoc_meas_1 AS
SELECT C.phy_doc_type_id,
 A.dsbrd_id,
 A.meas_id,
 A.phy_doc_dsbrd_meas_ord,
 T.text_desc AS meas_titl,
 T.tm_lvl_id,
 B.meas_fmt_id,
 TG.text_desc AS meas_grp_titl,
 B.tot_fl,
 B.avg_fl
FROM ldl_p_lew_process_mstr.v_ref_phdoc_dsbrd_meas_rel_act_1 AS A
 INNER JOIN ldl_p_lew_process_mstr.v_ref_text_act_1 AS T ON A.meas_text_id = T.text_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_phdoc_act_1 AS C ON A.phy_doc_id = C.phy_doc_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_act_1 AS B ON A.meas_id = B.meas_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_grp_act_1 AS MG ON B.meas_grp_id = MG.meas_grp_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_text_act_1 AS TG ON MG.meas_grp_text_id = TG.text_id
GROUP BY C.phy_doc_type_id,
 A.dsbrd_id,
 A.meas_id,
 A.phy_doc_dsbrd_meas_ord,
 meas_titl,
 T.tm_lvl_id,
 B.meas_fmt_id,
 meas_grp_titl,
 B.tot_fl,
 B.avg_fl;