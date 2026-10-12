CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mwst_per_2 AS SELECT mwst_id,
 dat_von,
 mandant_id,
 mwst,
 dat_bis,
 mwst_bez,
 spr_id,
 sap_mwst_id
FROM kfl_production_dbp_data.mwst_per_2;