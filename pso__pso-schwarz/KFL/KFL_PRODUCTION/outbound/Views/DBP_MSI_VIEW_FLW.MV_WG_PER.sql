CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_wg_per (wg_id, arthiertyp_id, lead_mwst_id, dat_von, abt_id,
mandant_id, dat_bis) AS SELECT wg_id,
 arthiertyp_id,
 lead_mwst_id,
 dat_von,
 abt_id,
 mandant_id,
 dat_bis
FROM kfl_production_dbp_view.v_wg_per
WHERE mandant_id IN (1, 2)
 AND arthiertyp_id = 2
 AND dat_bis > CURRENT_DATE;