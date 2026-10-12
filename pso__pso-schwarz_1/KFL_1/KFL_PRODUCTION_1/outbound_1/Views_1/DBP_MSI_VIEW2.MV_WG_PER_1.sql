CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wg_per_1 (wg_id, arthiertyp_id, lead_mwst_id, dat_von, abt_id,
mandant_id, dat_bis, owg_id, werbeteam_cd) AS SELECT wg_id,
 arthiertyp_id,
 lead_mwst_id,
 dat_von,
 abt_id,
 mandant_id,
 dat_bis,
 owg_id,
 werbeteam_cd
FROM kfl_production_dbp_view.v_wg_per_1
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';