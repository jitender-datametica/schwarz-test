CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_wg_owg_zu_2 (mandant_id, wg_id, arthiertyp_id, dat_von, lead_mwst_id,
abt_id, dat_bis, owg_id) AS SELECT mandant_id,
 wg_id,
 arthiertyp_id,
 dat_von,
 lead_mwst_id,
 abt_id,
 dat_bis,
 owg_id
FROM kfl_production_dbp_data.wg_per_2
WHERE dat_bis = DATE '9999-12-31';