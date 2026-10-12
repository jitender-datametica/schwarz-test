CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.v_ref_nvgtn_dsbrd_meas_ord_1 AS
SELECT CBR.dsbrd_id,
 CBR.blk_id,
 CBR.phy_doc_type_id,
 CBR.dsbrd_blk_ord,
 LM.meas_grp_id,
 SUM(1) OVER (PARTITION BY CAST(LM.meas_grp_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 meas_grp_cnt,
 LMBR.hd_row_ind,
 LMBR.blk_meas_titl_text_id,
 LMBR.blk_meas_titl2_text_id,
 LMBR.meas_id,
 LM.mstr_mtrc_guid,
 LMBR.tot_meas_id,
 TLM.mstr_mtrc_guid AS tot_mstr_mtrc_guid,
 LMBR.blk_meas_ord,
 RANK() OVER (ORDER BY CBR.dsbrd_blk_ord IS NULL, CBR.dsbrd_blk_ord, LMBR.blk_meas_ord IS NULL, LMBR.blk_meas_ord) AS
 dsbrd_meas_ord
FROM ldl_p_lew_process_mstr.v_ref_dsbrd_blk_rel_act_1 AS CBR
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_blk_rel_act_1 AS LMBR ON CBR.blk_id = LMBR.blk_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_act_1 AS LM ON LMBR.meas_id = LM.meas_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_act_1 AS TLM ON LMBR.tot_meas_id = TLM.meas_id
WHERE CBR.phy_doc_type_id = 4
GROUP BY CBR.dsbrd_id,
 CBR.blk_id,
 CBR.phy_doc_type_id,
 CBR.dsbrd_blk_ord,
 LM.meas_grp_id,
 LMBR.hd_row_ind,
 LMBR.blk_meas_titl_text_id,
 LMBR.blk_meas_titl2_text_id,
 LMBR.meas_id,
 LM.mstr_mtrc_guid,
 LMBR.tot_meas_id,
 tot_mstr_mtrc_guid,
 LMBR.blk_meas_ord; 