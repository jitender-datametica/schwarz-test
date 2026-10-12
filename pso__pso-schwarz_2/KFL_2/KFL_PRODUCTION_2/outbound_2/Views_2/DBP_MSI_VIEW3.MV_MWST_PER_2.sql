CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_mwst_per_2 (dat_bis, dat_von, mandant_id, mwst, mwst_bez, mwst_id,
sap_mwst_id, spr_id) AS SELECT dat_bis,
 dat_von,
 mandant_id,
 mwst,
 mwst_bez,
 mwst_id,
 sap_mwst_id,
 spr_id
FROM kfl_production_dbp_view.v_mwst_per_2;