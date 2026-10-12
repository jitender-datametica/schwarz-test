CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_lagerort_1 (mandant_id, mandant_kbez, lgort, werks, nb_id,
lagernummer_id) AS SELECT V01.mandant_id,
 V02.mandant_kbez,
 V01.lagerort_id AS lgort,
 V01.wup_id AS werks,
 V01.nb_id,
 V01.lagernummer_id
FROM kfl_production_dbp_view.v_l_lagerort_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id;