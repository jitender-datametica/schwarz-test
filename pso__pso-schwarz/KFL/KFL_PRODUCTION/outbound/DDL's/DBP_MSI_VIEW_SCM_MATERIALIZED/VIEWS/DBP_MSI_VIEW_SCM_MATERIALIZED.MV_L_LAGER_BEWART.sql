CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_lager_bewart (mandant_id, lager_bewart_id) AS
-- keine Beruecksichtigung der SAP-Industriesysteme fuer DE + CZ
 SELECT mandant_id,
 lager_bewart_id
FROM kfl_production_dbp_view.v_l_lager_bewart AS V01
WHERE system_id NOT IN (2, 17, 28, 32, 48, 53);