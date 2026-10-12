CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.v_ref_dsbrd_blk_phy_meas_desc_1 AS
SELECT DBM.phy_doc_type_id,
 DBM.dsbrd_id,
 DBM.blk_meas_ord,
 DBM.pg_no,
 DBM.blk_id,
 DBM.meas_id,
 T.text_desc AS meas_titl,
 NULLIF(T2.text_desc, '') AS meas_titl_2,
 T.tm_lvl_id,
 DBM.meas_grp_id,
 DBM.dsbrd_meas_ord,
 DBM.pg_meas_ord,
 TMG.text_desc AS meas_grp_titl,
 TB.text_desc AS blk_titl
FROM ldl_p_lew_process_mstr.t_agg_dsbrd_meas_pg_nvgtn_1 AS DBM
 INNER JOIN ldl_p_lew_process_mstr.v_ref_text_act_1 AS T ON DBM.blk_meas_titl_text_id = T.text_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_text_act_1 AS T2 ON DBM.blk_meas_titl2_text_id = T2.text_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_grp_act_1 AS MG ON DBM.meas_grp_id = MG.meas_grp_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_text_act_1 AS TMG ON MG.meas_grp_text_id = TMG.text_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_blk_act_1 AS B ON DBM.blk_id = B.blk_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_text_act_1 AS TB ON B.blk_titl_text_id = TB.text_id
WHERE T.tm_lvl_id = T2.tm_lvl_id
 OR T2.tm_lvl_id = 0
GROUP BY DBM.phy_doc_type_id,
 DBM.dsbrd_id,
 DBM.blk_meas_ord,
 DBM.pg_no,
 DBM.blk_id,
 DBM.meas_id,
 meas_titl,
 T2.text_desc,
 T.tm_lvl_id,
 DBM.meas_grp_id,
 DBM.dsbrd_meas_ord,
 DBM.pg_meas_ord,
 meas_grp_titl,
 blk_titl;