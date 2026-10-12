-- 22.06.2022 twie: SPEC0145413 Lookup Warengruppe
 CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_wg_per (wg_id
, arthiertyp_id, lead_mwst_id, dat_von, abt_id, mandant_id, dat_bis, owg_id) AS SELECT wg_id,
 arthiertyp_id,
 lead_mwst_id,
 dat_von,
 abt_id,
 mandant_id,
 dat_bis,
 owg_id
FROM kfl_production_dbp_view.v_wg_per
WHERE arthiertyp_id = 2
 AND dat_bis > CURRENT_DATE;