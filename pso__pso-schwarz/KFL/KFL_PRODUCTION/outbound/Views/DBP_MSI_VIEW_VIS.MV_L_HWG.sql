CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_hwg AS SELECT mandant_id,
 wg_hierarchie_id AS hwg_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per AS V01
WHERE arthiertyp_id = 5
 AND wg_hierarchie_ebene_id = 3
 AND dat_bis = DATE '9999-12-31';