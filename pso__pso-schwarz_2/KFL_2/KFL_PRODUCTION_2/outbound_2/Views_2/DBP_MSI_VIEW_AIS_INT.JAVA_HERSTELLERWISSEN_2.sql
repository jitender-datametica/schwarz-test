CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_herstellerwissen_2 (mandant_id, gp_id, dat_pflege,
dat_zeit_pflege, h452) AS SELECT mandant_id,
 CAST(gp_id AS STRING) AS gp_id,
 dat_pflege,
 dat_zeit_pflege,
 h452_herstellerwissen AS h452
FROM kfl_production_dbp_msi_v_view.v_herstellerwissen_2;