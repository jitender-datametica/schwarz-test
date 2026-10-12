CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_statusmeldung
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT V01.mandant_id,
 V01.statusmeldung_id,
 V01.ecm_vorgang,
 V01.zeitstempel,
 V01.dat,
 V01.dat_erfasst,
 V01.dat_buch,
 V01.statuscode_id,
 V01.ursprung_beleg_id,
 V01.ursprung_beleg_gj,
 V01.ersteller_id,
 V01.gp_id,
 V01.last_gp_id AS gp_id_last,
 V01.einkaufsorganisation_id,
 V01.auto_fg,
 V01.betrag_brutto,
 V01.betrag_mwst,
 V01.wrg_id,
 V01.quellsystem_id,
 V01.belegklasse_id,
 7 AS system_id,
 V01.fi_beleg_id,
 V01.imprint_nr,
 V01.edi_nr,
 V01.beleg_id,
 V01.beleg_gj,
 V01.beleg_id_orig AS rpw_beleg_zu_id,
 V01.manuelle_buchung_fg,
 V01.statusmeldung_ecm_lfd_nr,
 V01.last_fg,
 COALESCE(V02.wup_id, 0) AS wup_id,
  CASE
  WHEN V02.wup_id IS NULL
  THEN -1
  ELSE V02.nb_id
  END AS nb_id,
 V02.gp_lief_id,
 V02.dat_beleg,
 V02.betrag_brutto AS betrag_brutto_rech
FROM kfl_production_dbp_view.v_statusmeldung AS V01
 LEFT JOIN kfl_production_dbp_view.v_besch_rech AS V02 ON V01.beleg_id = V02.rech_beleg_id AND V01.beleg_gj = V02.gj AND
   V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id = 1;