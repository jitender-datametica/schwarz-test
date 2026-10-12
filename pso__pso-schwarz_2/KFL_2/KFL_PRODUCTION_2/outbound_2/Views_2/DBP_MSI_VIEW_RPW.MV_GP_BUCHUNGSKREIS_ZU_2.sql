CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_gp_buchungskreis_zu_2 (mandant_id, gp_id,
einkaufsorganisation_id, buchungskreis_id, zahlsperre_id, system_id) AS SELECT mandant_id,
 gp_id,
 einkaufsorganisation_id,
 buchungskreis_id,
 zahlsperre_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_gp_buchungskreis_zu_2
WHERE mandant_id = 1;