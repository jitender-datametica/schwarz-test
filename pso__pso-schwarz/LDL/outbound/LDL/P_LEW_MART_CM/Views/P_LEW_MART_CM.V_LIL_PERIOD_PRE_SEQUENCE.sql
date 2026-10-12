CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_period_pre_sequence (client_id, region_sid, region_id, period_sid,
period_id, per_text, per_text_en, period_lvl, seq_lift, seq_gl) AS SELECT t4.client_id,
 t4.region_sid,
 t4.region_id,
 t4.period_sid,
 t4.period_id,
 COALESCE(t4.period_name, t4.period_name0) AS per_text,
 COALESCE(t4.period_name1, t4.period_name0) AS per_text_en,
 t4.period_lvl,
 SUM(- 1) OVER (PARTITION BY CAST(t4.client_id AS STRING), CAST(t4.region_id AS STRING), CAST(t4.period_lvl AS STRING)
  ORDER BY t4.client_id IS NULL, t4.client_id, t4.period_id IS NULL, t4.period_id ROWS BETWEEN UNBOUNDED PRECEDING AND
  CURRENT ROW) AS seq_lift,
 SUM(- 1) OVER (PARTITION BY CAST(t4.client_id AS STRING), CAST(t4.region_id AS STRING), CAST(t4.period_lvl AS STRING)
  ORDER BY t4.client_id IS NULL, t4.client_id, t4.period_id IS NULL, t4.period_id ROWS BETWEEN UNBOUNDED PRECEDING AND
  CURRENT ROW) AS seq_gl
FROM (SELECT REGM.region_id,
   PERMS.period_lvl,
   PERMS.client_id,
   PERMS.period_id,
   PERMS.period_sid,
   REG.region_sid,
   DSDE.period_name,
   PC.period_name AS period_name0,
   DSEN.period_name AS period_name1
  FROM ldl_p_lew_process_mstr_ac.v_lil_period AS PERMS
   INNER JOIN ldl_p_lew_core_ac.v_lil_period AS PC ON PERMS.period_sid = PC.period_sid
   INNER JOIN ldl_p_lew_core_ac.v_lil_region AS REG ON PERMS.client_id = REG.client_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region AS REGM ON REG.region_sid = REGM.region_sid
   LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS DSDE ON PERMS.client_id = DSDE.client_id AND PERMS.period_sid =
      DSDE.period_sid AND DSDE.lang_cd = 'DE'
   LEFT JOIN ldl_p_lew_core_ac.v_lil_period_descr AS DSEN ON PERMS.client_id = DSEN.client_id AND PERMS.period_sid =
      DSEN.period_sid AND DSEN.lang_cd = 'EN'
  WHERE PERMS.period_id NOT IN (SELECT DISTINCT ltst_pseudo_period_id AS period_id
     FROM ldl_p_lew_process_mstr_ac.v_lil_period_type
     WHERE ltst_pseudo_period_id IS NOT NULL)
  GROUP BY REGM.region_id,
   PERMS.period_lvl,
   PERMS.client_id,
   PERMS.period_id,
   PERMS.period_sid,
   REG.region_sid,
   DSDE.period_name,
   period_name0,
   period_name1) AS t4;