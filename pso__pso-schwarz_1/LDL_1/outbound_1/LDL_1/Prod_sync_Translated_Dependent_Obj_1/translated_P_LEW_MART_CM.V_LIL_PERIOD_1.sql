CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_period_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT PP.period_id AS per_id,
 CAST(COALESCE(DSDE.period_name, PC.period_name) AS STRING) AS per_text,
 CAST(COALESCE(DSEN.period_name, PC.period_name) AS STRING) AS per_text_en,
 CAST(COALESCE(DSDE.period_name, PC.period_name) AS STRING) AS per_desc,
 CAST(COALESCE(DSEN.period_name, PC.period_name) AS STRING) AS per_desc_en,
 CAST(ROUND(PC.period_type_id) AS INTEGER) AS per_tp_id,
 CAST(ROUND(PP.period_lvl) AS INTEGER) AS per_lvl,
 CAST(ROUND(PC.period_year) AS INTEGER) AS per_yr,
 CAST(NULL AS DATE) AS per_start_dat,
 CAST(NULL AS DATE) AS per_end_dat,
 PYPP.period_id AS py_per_id,
 CAST(COALESCE(PYDSDE.period_name, PYPC.period_name) AS STRING) AS py_per_desc,
 CAST(COALESCE(PYDSEN.period_name, PYPC.period_name) AS STRING) AS py_per_desc_en,
 PQPP.period_id AS pq_per_id,
 CAST(COALESCE(PQDSDE.period_name, PQPC.period_name) AS STRING) AS pq_per_desc,
 CAST(COALESCE(PQDSEN.period_name, PQPC.period_name) AS STRING) AS pq_per_desc_en,
    TRUNC(CAST((PP.period_id - 2) / 100 AS BIGNUMERIC)) * 100 + MOD(MOD(PP.period_id - 1, 100) + 12, 13) + 1 AS
 pp_per_id,
 CAST(COALESCE(PPDSDE.period_name, PPPC.period_name) AS STRING) AS pp_per_desc,
 CAST(COALESCE(PPDSEN.period_name, PPPC.period_name) AS STRING) AS pp_per_desc_en,
  CASE
  WHEN MAX(PP.liam_avbl_fg) = 0
  THEN NULL
  ELSE 1
  END AS liam_avbl_fg,
  CASE
  WHEN MAX(PP.lift_avbl_fg) = 0
  THEN NULL
  ELSE 1
  END AS lift_avbl_fg
FROM ldl_p_lew_process_mstr_ac.v_lil_period_1 AS PP
 INNER JOIN ldl_p_lew_core_ac.v_lil_period_1 AS PC ON PP.period_sid = PC.period_sid
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_1 AS PYPC ON PC.period_sid_py = PYPC.period_sid
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_1 AS PQPC ON PC.period_sid_pq = PQPC.period_sid
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_1 AS PPPC ON PPPC.period_sid = TRUNC(CAST((PP.period_id - 2) / 100 AS BIGNUMERIC)
      ) * 100 + MOD(MOD(PP.period_id - 1, 100) + 12, 13) + 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_period_1 AS PYPP ON PC.period_sid_py = PYPP.period_sid
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_period_1 AS PQPP ON PC.period_sid_pq = PQPP.period_sid
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_period_1 AS PPPP ON PPPP.period_id = TRUNC(CAST((PP.period_id - 2) / 100 AS BIGNUMERIC)
      ) * 100 + MOD(MOD(PP.period_id - 1, 100) + 12, 13) + 1
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS DSDE ON PC.period_sid = DSDE.period_sid AND DSDE.lang_cd = 'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS DSEN ON PC.period_sid = DSEN.period_sid AND DSEN.lang_cd = 'EN'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS PYDSDE ON PYPC.period_sid = PYDSDE.period_sid AND PYDSDE.lang_cd =
   'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS PYDSEN ON PYPC.period_sid = PYDSEN.period_sid AND PYDSEN.lang_cd =
   'EN'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS PQDSDE ON PQPC.period_sid = PQDSDE.period_sid AND PQDSDE.lang_cd =
   'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS PQDSEN ON PQPC.period_sid = PQDSEN.period_sid AND PQDSEN.lang_cd =
   'EN'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS PPDSDE ON PPPP.period_sid = PPDSDE.period_sid AND PPDSDE.lang_cd =
   'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr_1 AS PPDSEN ON PPPP.period_sid = PPDSEN.period_sid AND PPDSEN.lang_cd =
   'EN'
GROUP BY per_id,
 per_text,
 per_text_en,
 per_desc,
 per_desc_en,
 per_tp_id,
 per_lvl,
 per_yr,
 per_start_dat,
 per_end_dat,
 py_per_id,
 py_per_desc,
 py_per_desc_en,
 pq_per_id,
 pq_per_desc,
 pq_per_desc_en,
 pp_per_id,
 pp_per_desc,
 pp_per_desc_en;