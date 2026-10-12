CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_wg_wup_pm_zu_per_2 (wup_id, nb_id, arthiertyp_id, matkl, pm_id,
dat_von, dat_bis, mandant_id) AS SELECT wup_id,
 nb_id,
 arthiertyp_id,
 wg_id AS matkl,
 pm_id,
 dat_von,
 dat_bis,
 mandant_id
FROM kfl_production_dbp_view.v_pm_wup_wg_zu_per_2
WHERE arthiertyp_id = 2
 AND dat_bis > CURRENT_DATE
 AND nb_id <> 99;