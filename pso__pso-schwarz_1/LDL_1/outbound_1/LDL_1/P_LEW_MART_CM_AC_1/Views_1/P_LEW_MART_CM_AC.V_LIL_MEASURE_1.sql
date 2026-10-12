CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_measure_1 (meas_id, meas_cd, meas_desc, meas_desc_en, meas_base_desc,
meas_base_desc_en, meas_tp_id, liam4_meas_grp_id, format_id, frac_lgth, liam1_srt_cd, liam2_srt_cd, liam3_srt_cd,
liam4_srt_cd, lift1_srt_cd, lcsd_srt_cd, monetary_fg) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_measure_1;