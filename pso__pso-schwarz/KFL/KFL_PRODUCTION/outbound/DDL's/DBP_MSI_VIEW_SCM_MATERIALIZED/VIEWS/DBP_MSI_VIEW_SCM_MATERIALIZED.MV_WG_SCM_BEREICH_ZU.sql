-- AP0182383, SPEC0207712, knop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wg_scm_bereich_zu (mandant_id, wg_id,
scm_bereich_id) AS SELECT WG.mandant_id,
 WG.wg_id,
 COALESCE(SCM.wg_hierarchie_mutter_id, -1) AS scm_bereich_id
FROM kfl_production_dbp_view.v_wg_per AS WG
 LEFT JOIN kfl_production_dbp_view.v_wg_hierarchie_zu_per AS SCM ON WG.mandant_id = SCM.mandant_id AND WG.wg_id = SCM.wg_hierarchie_id
     AND SCM.arthiertyp_id = 12
WHERE WG.dat_bis = DATE '9999-12-31'
 AND WG.arthiertyp_id = 2
GROUP BY WG.mandant_id,
 WG.wg_id,
 scm_bereich_id;