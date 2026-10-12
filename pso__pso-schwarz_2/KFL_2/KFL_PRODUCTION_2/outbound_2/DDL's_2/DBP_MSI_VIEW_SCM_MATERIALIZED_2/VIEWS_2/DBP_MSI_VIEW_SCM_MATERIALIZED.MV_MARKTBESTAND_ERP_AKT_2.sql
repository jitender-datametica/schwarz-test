CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_marktbestand_erp_akt_2 (mandant_id, wup_id, nb_id,
art_id, menge_lgbest_erp_frei_bme) AS SELECT V01.mandant_id,
 V05.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.art_id,
 V01.menge_lgbest_erp_frei_bme
FROM kfl_production_dbp_view.v_marktbestand_erp_delta_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0);