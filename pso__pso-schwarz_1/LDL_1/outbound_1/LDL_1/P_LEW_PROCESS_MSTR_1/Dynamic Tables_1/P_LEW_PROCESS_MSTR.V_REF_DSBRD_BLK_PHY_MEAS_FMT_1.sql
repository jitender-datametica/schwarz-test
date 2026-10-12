CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.v_ref_dsbrd_blk_phy_meas_fmt_1 AS
SELECT NAV.dsbrd_id,
 NAV.blk_id,
 NAV.phy_doc_type_id,
 NAV.meas_id,
 NAV.dsbrd_meas_ord,
 NAV.pg_meas_ord,
 NAV.pg_no,
 MEAS.meas_fmt_id
FROM ldl_p_lew_process_mstr.t_agg_dsbrd_meas_pg_nvgtn_1 AS NAV
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_act_1 AS MEAS ON NAV.meas_id = MEAS.meas_id;