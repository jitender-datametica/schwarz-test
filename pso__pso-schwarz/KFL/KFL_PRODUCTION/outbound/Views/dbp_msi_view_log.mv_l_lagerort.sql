CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagerort (mandant_id, wup_id, nb_id, lagernummer_id,
lagernummer_erp_id, lagerort_id) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 COALESCE(V02.lagernummer_id, '-99') AS lagernummer_id,
 LEFT(V01.lagernummer_id, 3) AS lagernummer_erp_id,
 V01.lagerort_id
FROM kfl_production_dbp_view.v_l_lagerort AS V01
 LEFT JOIN kfl_production_dbp_view.v_l_lagernummer AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
      AND V01.nb_id = V02.nb_id AND V01.lagernummer_id = V02.lagernummer_id
WHERE V01.lagerort_id NOT IN ('-2', '-3');