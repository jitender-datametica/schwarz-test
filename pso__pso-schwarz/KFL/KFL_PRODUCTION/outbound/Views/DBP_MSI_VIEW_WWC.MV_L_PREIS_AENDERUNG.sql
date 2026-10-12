CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_preis_aenderung (mandant_id, mandant_kbez, pv_grund) AS
SELECT V01.mandant_id,
 V02.mandant_kbez,
 V01.preis_aend_grund_id AS pv_grund
FROM kfl_production_dbp_view.v_l_preis_aenderung AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON V01.mandant_id = V02.mandant_id;