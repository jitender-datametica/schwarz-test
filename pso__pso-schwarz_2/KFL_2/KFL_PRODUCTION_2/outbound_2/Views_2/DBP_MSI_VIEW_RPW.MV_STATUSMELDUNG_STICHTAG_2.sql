CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_statusmeldung_stichtag_2 (statusmeldung_id, system_id,
mandant_id, imprint_nr, beleg_id, beleg_gj, ecm_vorgang, zeitstempel, dat_erfasst, dat_buch, dat_beleg, statuscode_id,
ursprung_beleg_id, ursprung_beleg_gj, ersteller_id, gp_id, einkaufsorganisation_id, auto_fg, betrag_brutto, betrag_mwst
, wrg_id, quellsystem_id, belegklasse_id, beleg_alter, beleg_alter_id, abteilung_id) AS SELECT SM.statusmeldung_id,
 7 AS system_id,
 SM.mandant_id,
 SM.imprint_nr,
 SM.beleg_id,
 SM.beleg_gj,
 SM.ecm_vorgang,
 SM.zeitstempel,
 SM.dat_erfasst,
 SM.dat_buch,
 DATE(SM.zeitstempel) AS dat_beleg,
 SM.statuscode_id,
 SM.ursprung_beleg_id,
 SM.ursprung_beleg_gj,
 SM.ersteller_id,
 SM.gp_id,
 SM.einkaufsorganisation_id,
 SM.auto_fg,
 SM.betrag_brutto,
 SM.betrag_mwst,
 SM.wrg_id,
 SM.quellsystem_id,
 SM.belegklasse_id,
 subsel.beleg_alter,
  CASE
  WHEN subsel.beleg_alter BETWEEN 0 AND 15
  THEN 1
  ELSE CASE
   WHEN subsel.beleg_alter BETWEEN 15 AND 30
   THEN 2
   ELSE CASE
    WHEN subsel.beleg_alter BETWEEN 31 AND 59
    THEN 3
    ELSE CASE
     WHEN subsel.beleg_alter BETWEEN 60 AND 89
     THEN 4
     ELSE CASE
      WHEN subsel.beleg_alter BETWEEN 90 AND 120
      THEN 5
      ELSE 6
      END
     END
    END
   END
  END AS beleg_alter_id,
 ERGZP.abteilung_id
FROM kfl_production_dbp_view.v_statusmeldung_2 AS SM_2
 INNER JOIN (SELECT BR.rech_beleg_id,
   BR.gj,
   BR.mandant_id,
   BR.dat_vorerfasst,
   MAX(SM0.statusmeldung_id) AS statusmeldung_id,
   DATE(MAX(SM0.zeitstempel)) AS dat_letzter_statuscode,
   DATE_DIFF(CURRENT_DATE, BR.dat_vorerfasst, DAY) AS beleg_alter
  FROM kfl_production_dbp_view.v_besch_rech_2 AS BR
   INNER JOIN kfl_production_dbp_view.v_statusmeldung_2 AS SM0 ON BR.rech_beleg_id = SM0.beleg_id AND BR.gj = SM0.beleg_gj
         AND BR.mandant_id = SM0.mandant_id AND BR.rech_beleg_status_id IN ('A', 'B') AND BR.belegart_id IN ('HS', 'HK'
      , 'IS', 'IK')
  GROUP BY BR.mandant_id,
   BR.rech_beleg_id,
   BR.gj,
   BR.dat_vorerfasst) AS subsel ON SM.beleg_id = subsel.rech_beleg_id AND SM.beleg_gj = subsel.gj AND SM.mandant_id =
    subsel.mandant_id AND SM.statusmeldung_id = subsel.statusmeldung_id
 INNER JOIN kfl_production_dbp_msi_view_rpw.mv_ersteller_rpw_gruppe_zu_per_2 AS ERGZP ON SM.ersteller_id = ERGZP.rpw_ersteller_id
     AND SM.mandant_id = ERGZP.mandant_id AND SM.dat_beleg BETWEEN ERGZP.dat_von AND ERGZP.dat_bis
WHERE SM.mandant_id = 1;