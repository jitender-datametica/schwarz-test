CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_avq_aktualisierung_2 AS SELECT mandant_id,
 kjwo,
 dat_letzte_aktualisierung
FROM kfl_production_dbp_view.v_avq_aktualisierung_2 AS V01;