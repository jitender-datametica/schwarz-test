CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wg_per_1 AS SELECT mandant_id,
 arthiertyp_id,
 lead_mwst_id,
 wg_id,
 owg_id,
 abt_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_wg_per_1 AS V01
WHERE dat_bis = DATE '9999-12-31'
 AND arthiertyp_id = 2;