CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_kunde_monat_1 (crm_kunde_id, dat_registrierung,
dat_abmeldung_original, letzter_tag_monat_abmeldung, dat_abmeldung_neu, registrierungsfiliale_mandant_id, kjmo) AS
-- Ermittlung letzter Tag_1 des Monats aus Abmeldedatum

-- Ermittlung, ob Abmeldedatum <= dem letzten Tag_1 des Abmeldedatums entspricht. Wenn ja, dann wird als Abmeldedatum der Vormonat ermittelt und Kunde zählt nur bis zum Vormonat

-- Begrenzung der Datenmenge
 SELECT t1.crm_kunde_id,
 t1.dat_registrierung,
 t1.dat_abmeldung_original,
 DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(t1.dat_abmeldung_original, MONTH), INTERVAL 31 DAY), MONTH), INTERVAL - 1
  DAY) AS letzter_tag_monat_abmeldung,
  CASE
  WHEN t1.dat_abmeldung_original <= DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(t1.dat_abmeldung_original, MONTH), INTERVAL
      31 DAY), MONTH), INTERVAL - 1 DAY)
  THEN DATE_ADD(DATE_TRUNC(t1.dat_abmeldung_original, MONTH), INTERVAL - 1 DAY)
  ELSE t1.dat_abmeldung_original
  END AS dat_abmeldung_neu,
 t1.registrierungsfiliale_mandant_id,
 t1.kjmo
FROM (SELECT v01.crm_kunde_id,
   DATE(v01.zeit_registrierung) AS dat_registrierung,
   DATE(v01.zeit_abmeldung) AS dat_abmeldung_original,
   v01.registrierungsfiliale_mandant_id,
   v02.kjmo
  FROM kfl_production_dbp_view.v_crm_l_kunde_1 AS v01
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS v02 ON v02.dat BETWEEN DATE(v01.zeit_registrierung) AND CASE
     WHEN DATE(v01.zeit_abmeldung) <= DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(DATE(v01.zeit_abmeldung), MONTH), INTERVAL
         31 DAY), MONTH), INTERVAL - 1 DAY)
     THEN DATE_ADD(DATE_TRUNC(DATE(v01.zeit_abmeldung), MONTH), INTERVAL - 1 DAY)
     ELSE DATE(v01.zeit_abmeldung)
     END
  WHERE v02.akt_mo <= 0
  GROUP BY v01.crm_kunde_id,
   dat_registrierung,
   dat_abmeldung_original,
   v01.registrierungsfiliale_mandant_id,
   v02.kjmo) AS t1_1;