CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_preis_aenderung_1 (mandant_id, preis_aend_grund_id) AS
SELECT mandant_id,
 preis_aend_grund_id
FROM kfl_production_dbp_view.v_l_preis_aenderung_1 AS V01
WHERE mandant_id <> 1
 AND (preis_aend_grund_id <> 7 OR mandant_id NOT IN (3, 6));