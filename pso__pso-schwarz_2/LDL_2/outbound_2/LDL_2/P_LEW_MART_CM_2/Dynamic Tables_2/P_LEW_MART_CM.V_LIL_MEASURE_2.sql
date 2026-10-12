CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_measure_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT MEMS.meas_id,
 CAST(MEMS.meas_cd AS STRING) AS meas_cd,
 CAST(COALESCE(TRDE.trans_text, MEMS.meas_desc) AS STRING) AS meas_desc,
 CAST(COALESCE(TREN.trans_text, MEMS.meas_desc) AS STRING) AS meas_desc_en,
 CAST(COALESCE(TRMDE.trans_text, MEMS.meas_base_desc) AS STRING) AS meas_base_desc,
 CAST(COALESCE(TRMEN.trans_text, MEMS.meas_base_desc) AS STRING) AS meas_base_desc_en,
 CAST(MEMS.meas_tp_id AS BIGNUMERIC) AS meas_tp_id,
 CAST(MEMS.liam4_meas_grp_id AS BIGNUMERIC) AS liam4_meas_grp_id,
 MEMS.format_id,
 CAST(MEMS.frac_lgth AS BIGNUMERIC) AS frac_lgth,
 MEMS.liam1_srt_cd,
 MEMS.liam2_srt_cd,
 MEMS.liam3_srt_cd,
 MEMS.liam4_srt_cd,
 MEMS.lift1_srt_cd,
 MEMS.lcsd_srt_cd,
 MEMS.monetary_fg
FROM ldl_p_lew_process_mstr_ac.v_lil_measure_2 AS MEMS
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TRDE ON TRDE.context = 'MEAS_DESC' AND MEMS.meas_id = TRDE.trans_id
      AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TREN ON TREN.context = 'MEAS_DESC' AND MEMS.meas_id = TREN.trans_id
      AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TRMDE ON TRMDE.context = 'MEAS_BASE_DESC' AND MEMS.meas_id =
     TRMDE.trans_id AND TRMDE.lang_cd = 'DE' AND TRMDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TRMEN ON TRMEN.context = 'MEAS_BASE_DESC' AND MEMS.meas_id =
     TRMEN.trans_id AND TRMEN.lang_cd = 'EN' AND TRMEN.active_fg = 1;
