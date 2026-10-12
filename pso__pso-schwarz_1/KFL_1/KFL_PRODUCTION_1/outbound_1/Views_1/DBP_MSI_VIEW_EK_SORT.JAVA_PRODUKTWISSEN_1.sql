CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_produktwissen_1 AS SELECT mandant_id,
 matching_id,
 dat_pflege,
 dat_zeit_pflege,
 f49_produktwissen
FROM kfl_production_dbp_msi_v_view.v_produktwissen_1 AS V1;