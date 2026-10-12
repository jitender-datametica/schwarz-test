CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_produktwissen AS SELECT mandant_id,
 matching_id,
 dat_zeit_pflege,
 dat_pflege,
 f49_produktwissen
FROM kfl_production_dbp_msi_data.produktwissen;