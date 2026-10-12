CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_lieferantenwissen_1 AS SELECT mandant_id,
 lieferant,
 dat_zeit_pflege,
 dat_pflege,
 c410_lieferantenwissen
FROM kfl_production_dbp_msi_data.lieferantenwissen_1;