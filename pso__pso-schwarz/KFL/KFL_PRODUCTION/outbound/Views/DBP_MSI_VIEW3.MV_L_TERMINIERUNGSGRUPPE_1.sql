CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_terminierungsgruppe_1 (mandant_id, terminierungsgruppe_1_id) AS
SELECT mandant_id,
 terminierungsgruppe_1_id
FROM kfl_production_dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per AS V01
GROUP BY mandant_id,
 terminierungsgruppe_1_id
UNION DISTINCT
SELECT mandant_id,
 '-1' AS terminierungsgruppe_1_id
FROM kfl_production_dbp_view.v_mandant AS V02
WHERE (mandant_id, '-1') NOT IN (SELECT (mandant_id, terminierungsgruppe_1_id)
   FROM kfl_production_dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per);