CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_wg_per_2 (wg_id, arthiertyp_id, lead_mwst_id, dat_von, abt_id,
mandant_id, dat_bis, owg_id) AS SELECT wg_id,
 arthiertyp_id,
 lead_mwst_id,
 dat_von,
 abt_id,
 mandant_id,
 dat_bis,
 owg_id
FROM kfl_production_dbp_view.v_wg_per_2
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND dat_bis > CURRENT_DATE;