CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_terminierungsgruppe_2_spr_zu_2 (mandant_id, spr_id,
terminierungsgruppe_2_id, terminierungsgruppe_2_bez) AS SELECT V01.mandant_id,
 V02.spr_id,
 V01.terminierungsgruppe_2_id,
  CASE
  WHEN V01.terminierungsgruppe_2_id = '-1'
  THEN SUBSTR('nicht gepflegt      ', 1, 20)
  ELSE SUBSTR(CAST(V01.terminierungsgruppe_2_id AS STRING), 1, 20)
  END AS terminierungsgruppe_2_bez
FROM kfl_production_dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_2 AS V02 ON TRUE
GROUP BY V01.mandant_id,
 V01.terminierungsgruppe_2_id,
 V02.spr_id
UNION DISTINCT
SELECT V01.mandant_id,
 V02.spr_id,
 '-1' AS terminierungsgruppe_2_id,
 'nicht gepflegt' AS terminierungsgruppe_2_bez
FROM kfl_production_dbp_view.v_mandant_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_2 AS V02 ON TRUE
WHERE (V01.mandant_id, '-1') NOT IN (SELECT (mandant_id, terminierungsgruppe_2_id)
   FROM kfl_production_dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_2);