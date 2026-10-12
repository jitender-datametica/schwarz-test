CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_statusmeldung_1 (mandant_id, statusmeldung_id, ecm_vorgang,
zeitstempel, dat, dat_erfasst, dat_buch, statuscode_id, ursprung_beleg_id, ursprung_beleg_gj, ersteller_id, gp_id,
gp_id_last, einkaufsorganisation_id, auto_fg, betrag_brutto, betrag_mwst, wrg_id, quellsystem_id, belegklasse_id,
system_id, fi_beleg_id, imprint_nr, edi_nr, beleg_id, beleg_gj, rpw_beleg_zu_id, manuelle_buchung_fg,
statusmeldung_ecm_lfd_nr, last_fg, wup_id, nb_id, gp_lief_id, dat_beleg, betrag_brutto_rech) AS SELECT V01.mandant_id,
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
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE V02.nb_id
  END AS nb_id,
 V02.gp_lief_id,
 V02.dat_beleg,
 V02.betrag_brutto AS betrag_brutto_rech
FROM kfl_production_dbp_view.v_statusmeldung_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_besch_rech_1 AS V02 ON V01.beleg_id = V02.rech_beleg_id AND V01.beleg_gj = V02.gj AND
   V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id = 1;