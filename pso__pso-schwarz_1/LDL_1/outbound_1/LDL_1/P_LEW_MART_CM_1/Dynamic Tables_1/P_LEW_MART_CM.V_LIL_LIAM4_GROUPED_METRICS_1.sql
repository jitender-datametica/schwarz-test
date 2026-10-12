
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.v_lil_liam4_grouped_metrics_1
 AS
SELECT MEAS.meas_id,
 MEAS.meas_cd AS liam4_meas_cd,
 CAST(MEAS.meas_desc AS STRING) AS liam4_meas_desc,
 CAST(MEAS.meas_desc_en AS STRING) AS liam4_meas_desc_en,
 REPLACE(REPLACE(MEAS.meas_desc, '(Packung) (000)', ''), 'Packung (000)', '') AS liam4_meas_smart_desc,
 REPLACE(MEAS.meas_desc_en, ' Packs (000)', '') AS liam4_meas_smart_desc_en,
 MEAS.liam4_meas_grp_id AS grp_id,
 CAST(GRP.meas_grp_desc AS STRING) AS grp_desc,
 CAST(GRP.meas_grp_desc_en AS STRING) AS grp_desc_en,
  CASE
  WHEN MEAS.liam4_meas_grp_id = 4
  THEN 'Gesamtmarkt (alle shopper_1)'
  WHEN MEAS.liam4_meas_grp_id = 6
  THEN 'Lidl Shopper_1 im Wettbewerber 1'
  WHEN MEAS.liam4_meas_grp_id = 7
  THEN 'Lidl Shopper_1 im Wettbewerber 2'
  ELSE CAST(GRP.meas_grp_desc AS STRING)
  END AS grp_smart_desc,
  CASE
  WHEN MEAS.liam4_meas_grp_id = 4
  THEN 'Total Market (all shopper_1)'
  WHEN MEAS.liam4_meas_grp_id = 6
  THEN 'Lidl Shopper_1 at Comp. 1'
  WHEN MEAS.liam4_meas_grp_id = 7
  THEN 'Lidl Shopper_1 at Comp. 2'
  ELSE CAST(GRP.meas_grp_desc_en AS STRING)
  END AS grp_smart_desc_en,
 MEAS.liam4_srt_cd AS liam4_meas_id
FROM ldl_p_lew_mart_cm.v_lil_measure_1 AS MEAS
 INNER JOIN ldl_p_lew_mart_cm.v_lil_measure_group_1 AS GRP ON MEAS.liam4_meas_grp_id = GRP.meas_grp_id
WHERE MEAS.liam4_meas_grp_id NOT IN (- 1, 1)
 AND MEAS.meas_id NOT IN (8, 24);
