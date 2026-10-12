CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_kunde_monat_2 (crm_kunde_id, dat_registrierung,
dat_abmeldung_original, letzter_tag_monat_abmeldung, dat_abmeldung_neu, registrierungsfiliale_mandant_id, kjmo) AS
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
FROM (SELECT V01.crm_kunde_id,
   DATE(V01.zeit_registrierung) AS dat_registrierung,
   DATE(V01.zeit_abmeldung) AS dat_abmeldung_original,
   V01.registrierungsfiliale_mandant_id,
   V02.kjmo
  FROM kfl_production_dbp_view.v_crm_l_kunde_2 AS V01
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V02.dat BETWEEN DATE(V01.zeit_registrierung) AND CASE
     WHEN DATE(V01.zeit_abmeldung) <= DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(DATE(V01.zeit_abmeldung), MONTH), INTERVAL
         31 DAY), MONTH), INTERVAL - 1 DAY)
     THEN DATE_ADD(DATE_TRUNC(DATE(V01.zeit_abmeldung), MONTH), INTERVAL - 1 DAY)
     ELSE DATE(V01.zeit_abmeldung)
     END
  WHERE V02.akt_mo <= 0
  GROUP BY V01.crm_kunde_id,
   dat_registrierung,
   dat_abmeldung_original,
   V01.registrierungsfiliale_mandant_id,
   V02.kjmo) AS t1_2;