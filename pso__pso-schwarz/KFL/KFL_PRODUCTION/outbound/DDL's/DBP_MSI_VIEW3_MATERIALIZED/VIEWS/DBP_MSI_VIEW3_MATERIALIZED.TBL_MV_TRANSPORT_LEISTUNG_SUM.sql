CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.tbl_mv_transport_leistung_sum (lagernummer_id,
mandant_id, von_lagertyp_id, nach_lagertyp_id, wup_id, nb_id, leist_empfaenger_gruppe_id, dat_leistung, transport_gv_id
, gp_id, menge_kolli, zeit_sekunden, zeit_ruest_sekunden, zeit_pause_sekunden, anzahl_transportauftrag,
anzahl_versandblock, anzahl_ruestzeit, anzahl_pause, ext_ma_fg, leist_empfaenger_sap_id) AS
-- Bei anonymisierten Usern kann es zwei Einträge pro SAP-Gruppe geben (EXT_MA_FG 0 UND 1) -> um eine Duplizierung der Ergebnisse zu verhindern nehmen wir das min()

SELECT V01.lagernummer_id,
 V01.mandant_id,
 V01.von_lagertyp_id,
 V01.nach_lagertyp_id,
 V01.wup_id,
 V01.nb_id,
 V01.leist_empfaenger_gruppe_id,
 V01.dat_leistung,
 V01.transport_gv_id,
 V01.gp_id,
 V01.menge_kolli,
 V01.zeit_sekunden,
 V01.zeit_ruest_sekunden,
 V01.zeit_pause_sekunden,
 V01.anzahl_transportauftrag,
 V01.anzahl_versandblock,
 V01.anzahl_ruestzeit,
 V01.anzahl_pause,
 v04.ext_ma_fg,
 V01.leist_empfaenger_sap_id
FROM kfl_production_dbp_view.v_transport_leistung_sum AS V01
 INNER JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   leist_empfaenger_sap_id,
   leist_empfaenger_gruppe_id,
   MIN(ext_ma_fg) AS ext_ma_fg
  FROM kfl_production_dbp_view.v_l_leist_empfaenger
  GROUP BY mandant_id,
   leist_empfaenger_sap_id,
   leist_empfaenger_gruppe_id,
   wup_id,
   nb_id) AS v04 ON V01.mandant_id = v04.mandant_id AND V01.wup_id = v04.wup_id AND V01.nb_id = v04.nb_id AND V01.leist_empfaenger_sap_id
     = v04.leist_empfaenger_sap_id AND V01.leist_empfaenger_gruppe_id = v04.leist_empfaenger_gruppe_id;