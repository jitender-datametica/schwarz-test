CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_hwg_sortimentsbereich_zu (hwg_id, mandant_id,
sortimentsbereich_id) AS SELECT HWG.hwg_id,
 HWG.mandant_id,
 COALESCE(SCM.wg_hierarchie_mutter_id, - 1) AS sortimentsbereich_id
FROM kfl_production_dbp_view.v_hwg_per AS HWG
 LEFT JOIN kfl_production_dbp_view.v_wg_hierarchie_zu_per AS SCM ON HWG.mandant_id = SCM.mandant_id AND HWG.hwg_id = SCM
    .wg_hierarchie_id AND SCM.arthiertyp_id = 13
WHERE HWG.dat_bis = DATE '9999-12-31'
 AND HWG.arthiertyp_id = 2
GROUP BY HWG.hwg_id,
 HWG.mandant_id,
 sortimentsbereich_id;