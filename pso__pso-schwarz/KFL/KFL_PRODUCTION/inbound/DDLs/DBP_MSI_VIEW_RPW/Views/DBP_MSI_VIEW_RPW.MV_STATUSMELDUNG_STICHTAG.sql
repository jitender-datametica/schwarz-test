CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_STATUSMELDUNG_STICHTAG
(
statusmeldung_id
, system_id
, mandant_id
, imprint_nr
, beleg_id
, beleg_gj
, ecm_vorgang
, zeitstempel
, dat_erfasst
, dat_buch
, dat_beleg
, statuscode_id
, ursprung_beleg_id
, ursprung_beleg_gj
, ersteller_id
, gp_id
, einkaufsorganisation_id
, auto_fg
, betrag_brutto
, betrag_mwst
, wrg_id
, quellsystem_id
, belegklasse_id
, beleg_alter
, beleg_alter_id
, abteilung_id
)
AS
   SELECT
   sm.statusmeldung_id,
   7,
   sm.mandant_id,
   sm.imprint_nr,
   sm.beleg_id,
   sm.beleg_gj,
   sm.ecm_vorgang,
   sm.zeitstempel,
   sm.dat_erfasst,
   sm.dat_buch,
   CAST(zeitstempel AS DATE) AS dat_beleg,
   sm.statuscode_id,
   sm.ursprung_beleg_id,
   sm.ursprung_beleg_gj,
   sm.ersteller_id,
   sm.gp_id,
   sm.einkaufsorganisation_id,
   sm.auto_fg,
   sm.betrag_brutto,
   sm.betrag_mwst,
   sm.wrg_id,
   sm.quellsystem_id,
   sm.belegklasse_id,
   subsel.beleg_alter,
   CASE WHEN subsel.beleg_alter  BETWEEN 0 AND 15 THEN 1 ELSE
CASE WHEN subsel.beleg_alter BETWEEN 15 AND  30 THEN 2 ELSE
CASE WHEN subsel.beleg_alter BETWEEN 31 AND  59 THEN 3 ELSE
CASE WHEN subsel.beleg_alter BETWEEN 60 AND  89 THEN 4 ELSE
CASE WHEN subsel.beleg_alter BETWEEN 90 AND  120 THEN  5 ELSE 6 END
END
END
END
END AS beleg_alter_id,
   ergzp.abteilung_id


FROM dbp_view.v_statusmeldung sm

   JOIN (
   SELECT
   br.rech_beleg_id,
   br.gj,
   br.mandant_id,
   br.dat_vorerfasst,
   MAX(sm.statusmeldung_id) AS statusmeldung_id,
   CAST(MAX(sm.zeitstempel) AS DATE) AS dat_letzter_statuscode,
   (CURRENT_DATE - br.dat_vorerfasst) AS beleg_alter
   FROM dbp_view.v_besch_rech br
   JOIN dbp_view.v_statusmeldung sm
   ON br.rech_beleg_id   =sm.beleg_id
   AND br.gj          =sm.beleg_gj
   AND br.mandant_id  =sm.mandant_id
   AND br.rech_beleg_status_id IN ('A', 'B')
   AND br.belegart_id IN ('HS','HK', 'IS', 'IK')

   GROUP BY 1,2,3,4

   ) subsel
   ON subsel.rech_beleg_id = sm.beleg_id
   AND subsel.gj = sm.beleg_gj
   AND subsel.mandant_id  =sm.mandant_id
   AND subsel.statusmeldung_id = sm.statusmeldung_id

   JOIN dbp_msi_view_rpw.mv_ersteller_rpw_gruppe_zu_per ergzp
   ON sm.ersteller_id = ergzp.rpw_ersteller_id
   AND sm.mandant_id = ergzp.mandant_id
   AND dat_beleg BETWEEN ergzp.dat_von AND ergzp.dat_bis

   WHERE sm.mandant_id = 1;