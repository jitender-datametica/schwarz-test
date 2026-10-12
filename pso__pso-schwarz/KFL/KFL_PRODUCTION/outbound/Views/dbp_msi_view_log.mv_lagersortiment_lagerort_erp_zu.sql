CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagersortiment_lagerort_erp_zu AS SELECT V01.mandant_id,
 COALESCE(V02.lagerort_id, '-1') AS lagerort_id,
 V01.lagersortiment_id,
 V01.lagernummer_id,
 V01.wup_id,
 V01.nb_id
FROM kfl_production_dbp_view.v_l_lagersortiment AS V01
 LEFT JOIN kfl_production_dbp_view.v_lagerort_lagersortiment_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id
     = V02.wup_id AND V01.lagersortiment_id = V02.lagersortiment_id
WHERE V01.wup_id > 0;