-- 2023-08-07, AP0182383, SPEC0207712, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_wg_sortimentsgruppe_1 (wg_id, mandant_id,
sortimentsgruppe_id, arthiertyp_id) AS SELECT WG.wg_id,
 WG.mandant_id,
 COALESCE(SCM.wg_hierarchie_mutter_id, -1) AS sortimentsgruppe_id,
 WG.arthiertyp_id
FROM kfl_production_dbp_view.v_wg_per_1 AS WG
 LEFT JOIN kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS SCM ON WG.mandant_id = SCM.mandant_id AND WG.wg_id = SCM.wg_hierarchie_id
     AND SCM.arthiertyp_id = 11
WHERE WG.dat_bis = DATE '9999-12-31'
 AND WG.arthiertyp_id = 2
GROUP BY WG.wg_id,
 sortimentsgruppe_id,
 WG.mandant_id,
 WG.arthiertyp_id;