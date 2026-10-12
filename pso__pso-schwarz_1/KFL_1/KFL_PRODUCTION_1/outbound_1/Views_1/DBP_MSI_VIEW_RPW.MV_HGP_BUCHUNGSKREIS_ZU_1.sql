CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_hgp_buchungskreis_zu_1 (mandant_id, hgp_id,
einkaufsorganisation_id, buchungskreis_id, zahlsperre_id, system_id) AS SELECT mandant_id,
 gp_id AS hgp_id,
 einkaufsorganisation_id,
 buchungskreis_id,
 zahlsperre_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_gp_buchungskreis_zu_1
WHERE mandant_id = 1
 AND gp_id < 1000000;