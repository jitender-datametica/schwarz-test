CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_wg_per_1 (wg_id, arthiertyp_id, mandant_id, lead_mwst_id,
dat_von, abt_id, dat_bis, system_id, owg_id) AS SELECT wg_id,
 arthiertyp_id,
 mandant_id,
 lead_mwst_id,
 dat_von,
 abt_id,
 dat_bis,
 7 AS system_id,
 owg_id
FROM kfl_production_dbp_view.v_wg_per_1
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
 AND abt_id NOT IN (0, - 1, - 2, - 3);