CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_herstellerwissen AS SELECT mandant_id,
 CAST(gp_id AS STRING) AS gp_id,
 dat_pflege,
 dat_zeit_pflege,
 h452_herstellerwissen AS h452
FROM kfl_production_dbp_msi_v_view.v_herstellerwissen;