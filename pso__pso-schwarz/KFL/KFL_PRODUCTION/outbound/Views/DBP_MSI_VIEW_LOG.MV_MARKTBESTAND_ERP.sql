CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_marktbestand_erp AS SELECT V01.mandant_id,
 V01.art_id,
 V05.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.dat,
 V01.bestand_id,
 V01.bezugsweg_id,
 V01.relevant_fg,
 V01.menge_lgbest_erp_frei_bme,
 V01.menge_lgbest_erp_qual_bme,
 V01.menge_lgbest_erp_gesp_bme,
 V01.fortschreibung_fg
FROM kfl_production_dbp_view.v_marktbestand_erp AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND V01
   .nb_id = V05.nb_id;