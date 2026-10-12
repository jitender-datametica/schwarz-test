CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_terminierungsgruppe_2_2 (mandant_id, terminierungsgruppe_2_id) AS
SELECT mandant_id,
 terminierungsgruppe_2_id
FROM kfl_production_dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_2 AS V01
GROUP BY mandant_id,
 terminierungsgruppe_2_id
UNION DISTINCT
SELECT mandant_id,
 '-1' AS terminierungsgruppe_2_id
FROM kfl_production_dbp_view.v_mandant_2 AS V02
WHERE (mandant_id, '-1') NOT IN (SELECT (mandant_id, terminierungsgruppe_2_id)
   FROM kfl_production_dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_2);