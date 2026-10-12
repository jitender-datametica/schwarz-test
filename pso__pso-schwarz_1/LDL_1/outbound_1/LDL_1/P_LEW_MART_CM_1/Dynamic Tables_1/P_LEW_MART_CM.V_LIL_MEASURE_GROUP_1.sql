CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_measure_group_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT CAST(MEGM.meas_grp_id AS BIGNUMERIC) AS meas_grp_id,
 CAST(COALESCE(TRDE.trans_text, MEGM.meas_grp_desc) AS STRING) AS meas_grp_desc,
 CAST(COALESCE(TREN.trans_text, MEGM.meas_grp_desc) AS STRING) AS meas_grp_desc_en
FROM ldl_p_lew_process_mstr_ac.v_lil_measure_group_1 AS MEGM
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_1 AS TRDE ON TRDE.context = 'MEAS_GRP_DESC' AND MEGM.meas_grp_id =
     TRDE.trans_id AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_1 AS TREN ON TREN.context = 'MEAS_GRP_DESC' AND MEGM.meas_grp_id =
     TREN.trans_id AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1;

