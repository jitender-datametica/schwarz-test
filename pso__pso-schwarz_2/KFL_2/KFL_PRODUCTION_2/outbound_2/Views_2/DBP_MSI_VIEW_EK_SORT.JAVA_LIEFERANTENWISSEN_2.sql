CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_lieferantenwissen_2 AS SELECT mandant_id,
 lieferant,
 dat_pflege,
 dat_zeit_pflege,
 c410_lieferantenwissen
FROM kfl_production_dbp_msi_v_view.v_lieferantenwissen_2 AS V1;