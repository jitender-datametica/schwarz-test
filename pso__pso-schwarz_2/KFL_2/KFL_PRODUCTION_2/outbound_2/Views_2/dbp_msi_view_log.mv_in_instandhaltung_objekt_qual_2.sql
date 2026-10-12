CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_instandhaltung_objekt_qual_2 (mandant_id, qual_meldung_id,
tp_objekt_id, auftrag_id, techn_platz_id, dat_stoer_beginn) AS SELECT mandant_id,
 qual_meldung_id,
 tp_objekt_id,
 auftrag_id,
 techn_platz_id,
 dat_stoer_beginn
FROM kfl_production_dbp_view.v_in_instandhaltung_objekt_qual_2 AS V01;