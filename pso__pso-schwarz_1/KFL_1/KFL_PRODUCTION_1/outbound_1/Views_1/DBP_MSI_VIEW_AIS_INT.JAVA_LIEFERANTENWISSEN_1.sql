CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_lieferantenwissen_1 (mandant_id, lieferant, dat_pflege,
dat_zeit_pflege, c410_lieferantenwissen) AS SELECT mandant_id,
 lieferant,
 dat_pflege,
 dat_zeit_pflege,
 c410_lieferantenwissen
FROM kfl_production_dbp_msi_v_view.v_lieferantenwissen_1 AS V1;