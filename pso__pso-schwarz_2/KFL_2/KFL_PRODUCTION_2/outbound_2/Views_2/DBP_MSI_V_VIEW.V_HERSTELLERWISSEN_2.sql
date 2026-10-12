CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_herstellerwissen_2 AS SELECT mandant_id,
 gp_id,
 dat_zeit_pflege,
 dat_pflege,
 h452_herstellerwissen
FROM kfl_production_dbp_msi_data.herstellerwissen_2;