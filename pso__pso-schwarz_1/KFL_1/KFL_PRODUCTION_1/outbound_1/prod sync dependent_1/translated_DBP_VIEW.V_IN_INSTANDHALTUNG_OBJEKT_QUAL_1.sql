CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_instandhaltung_objekt_qual_1 (mandant_id, qual_meldung_id,
tp_objekt_id, auftrag_id, techn_platz_id, dat_stoer_beginn, cs_auftrag_prio) AS SELECT mandant_id,
 qual_meldung_id,
 tp_objekt_id,
 auftrag_id,
 techn_platz_id,
 dat_stoer_beginn,
 cs_auftrag_prio
FROM kfl_production_dbp_data.in_instandhaltung_objekt_qual_1;