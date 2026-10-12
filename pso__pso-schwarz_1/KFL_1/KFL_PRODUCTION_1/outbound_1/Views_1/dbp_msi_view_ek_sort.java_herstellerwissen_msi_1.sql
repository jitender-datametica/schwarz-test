CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_herstellerwissen_msi_1 AS SELECT mandant_id,
 gp_id,
 h452_herstellerwissen AS h452,
 MAX(dat_pflege) AS dat_pflege
FROM kfl_production_dbp_msi_v_view.v_herstellerwissen_1 AS T1_1
GROUP BY mandant_id,
 gp_id,
 h452;