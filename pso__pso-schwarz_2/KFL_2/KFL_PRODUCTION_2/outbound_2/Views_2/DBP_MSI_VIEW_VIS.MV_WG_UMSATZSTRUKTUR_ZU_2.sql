CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wg_umsatzstruktur_zu_2 AS SELECT mandant_id,
 wg_hierarchie_id AS wg_id,
 wg_hierarchie_mutter_id AS umsatzstruktur_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_2
WHERE arthiertyp_id = 8
 AND dat_bis = DATE '9999-12-31';