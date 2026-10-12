CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_autodispocluster_wg_zu_per_1 AS SELECT mandant_id,
 wg_hierarchie_id AS wg_id,
 wg_hierarchie_mutter_id AS autodispo_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_1
WHERE arthiertyp_id = 9
 AND mandant_id = 1
 AND wg_hierarchie_ebene_id = 0
 AND CURRENT_DATE BETWEEN dat_von AND dat_bis;