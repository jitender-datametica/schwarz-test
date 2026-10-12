CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_wg_per (mandant_id, arthiertyp_id, lead_mwst_id, wg_id,
abt_id, dat_von, dat_bis, owg_id) AS SELECT mandant_id,
 arthiertyp_id,
 lead_mwst_id,
 wg_id,
 abt_id,
 dat_von,
 dat_bis,
 owg_id
FROM kfl_production_dbp_view.v_wg_per AS V01
WHERE dat_bis > CURRENT_DATE
 AND arthiertyp_id = 2;