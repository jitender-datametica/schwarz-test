CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_buchungskreis_1 (mandant_id, mandant_kbez, bukrs) AS SELECT
 V01.mandant_id,
 V02.mandant_kbez,
 V01.buchungskreis_id AS bukrs
FROM kfl_production_dbp_view.v_l_buchungskreis_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id;