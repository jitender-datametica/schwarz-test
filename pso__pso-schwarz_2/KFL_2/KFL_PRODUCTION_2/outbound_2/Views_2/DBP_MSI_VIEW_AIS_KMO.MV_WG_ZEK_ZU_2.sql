CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wg_zek_zu_2 (arthiertyp_id, mandant_id, wg_id, zek_id) AS
SELECT arthiertyp_id,
 mandant_id,
 wg_id,
 zek_id
FROM kfl_production_dbp_msi_v_view.v_wg_zek_zu_2
WHERE mandant_id > 1;