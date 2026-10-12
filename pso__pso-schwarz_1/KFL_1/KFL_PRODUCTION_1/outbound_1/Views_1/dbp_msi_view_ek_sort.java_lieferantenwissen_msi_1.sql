CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_lieferantenwissen_msi_1 AS SELECT mandant_id,
 lieferant,
 c410_lieferantenwissen,
 MAX(dat_pflege) AS dat_pflege
FROM kfl_production_dbp_msi_v_view.v_lieferantenwissen_1 AS V1
GROUP BY mandant_id,
 lieferant,
 c410_lieferantenwissen;