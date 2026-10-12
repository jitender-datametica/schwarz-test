CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_dra_wup_tag_2 (mandant_id, wup_id, dat, betrag_dra, anz_bon) AS
SELECT V01.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.dat,
 V01.betrag_dra,
 V01.anz_bon
FROM kfl_production_dbp_view.v_dra_wup_tag_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;