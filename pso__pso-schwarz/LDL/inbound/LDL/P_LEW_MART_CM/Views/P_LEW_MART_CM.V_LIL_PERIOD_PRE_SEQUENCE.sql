CREATE OR REPLACE VIEW p_lew_mart_cm.v_lil_period_pre_sequence
(
  client_id
, region_sid
, region_id
, period_sid
, period_id
, per_text
, per_text_EN
, period_lvl
, seq_lift
, seq_gl
)
AS
SELECT
perms.client_id,
reg.region_sid,
regm.region_id,
perms.period_sid,
perms.period_id,
COALESCE(dsde.period_name, pc.period_name) AS per_text,
COALESCE(dsen.period_name, pc.period_name) AS per_text_EN,
perms.period_lvl,
SUM(-1) OVER (PARTITION BY   perms.client_id ,regm.region_id, perms.period_lvl ORDER BY perms.client_id, perms.period_id DESC NULLS LAST ROWS UNBOUNDED PRECEDING) AS seq_lift,
SUM(-1) OVER (PARTITION BY   perms.client_id,  regm.region_id, perms.period_lvl  ORDER BY perms.client_id, perms.period_id DESC NULLS LAST ROWS UNBOUNDED PRECEDING) AS seq_gl
FROM p_lew_process_mstr_ac.v_lil_period AS perms
INNER JOIN p_lew_core_ac.v_lil_period AS pc
ON pc.period_sid = perms.period_sid
INNER JOIN p_lew_core_ac.v_lil_region AS reg
ON reg.client_id = perms.client_id
INNER JOIN p_lew_process_mstr_ac.v_lil_region AS regm
ON regm.region_sid = reg.region_sid
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr AS dsde
ON dsde.client_id = perms.client_id
AND dsde.period_sid = perms.period_sid
AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN p_lew_core_ac.v_lil_period_descr AS dsen
ON dsen.client_id = perms.client_id
AND dsen.period_sid = perms.period_sid
AND dsen.lang_cd = 'EN'
WHERE perms.period_id NOT IN (SELECT DISTINCT ltst_pseudo_period_id AS period_id
FROM p_lew_process_mstr_ac.v_lil_period_type
WHERE ltst_pseudo_period_id IS NOT NULL
)
GROUP BY regm.region_id, perms.period_lvl, perms.client_id, perms.period_id, perms.period_sid, reg.region_sid, dsde.period_name, pc.Period_name, dsen.period_name;