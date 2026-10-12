-- 2023-08-07, AP0182383, SPEC0207712, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wg_sortimentsgruppe (wg_id, sortimentsgruppe_id)
AS SELECT WG.wg_id,
 COALESCE(SCM.wg_hierarchie_mutter_id, -1) AS sortimentsgruppe_id
FROM kfl_production_dbp_view.v_wg_per AS WG
 LEFT JOIN kfl_production_dbp_view.v_wg_hierarchie_zu_per AS SCM ON WG.mandant_id = SCM.mandant_id AND WG.wg_id = SCM.wg_hierarchie_id
     AND SCM.arthiertyp_id = 11
WHERE WG.dat_bis = DATE '9999-12-31'
 AND WG.arthiertyp_id = 2
GROUP BY WG.wg_id,
 sortimentsgruppe_id;