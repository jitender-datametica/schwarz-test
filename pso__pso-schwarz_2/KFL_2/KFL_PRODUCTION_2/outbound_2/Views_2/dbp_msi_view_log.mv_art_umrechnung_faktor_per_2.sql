CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_art_umrechnung_faktor_per_2 AS SELECT V01.mandant_id,
 V01.art_id,
 V01.dat_von,
 V01.dat_bis,
  CAST(V02_PAL.umrech_zaehler AS FLOAT64) / CAST(V02_PAL.umrech_nenner AS FLOAT64) AS umrech_faktor,
  CASE
  WHEN TRIM(V01.ausg_menge_einh_id) = ''
  THEN 'ST'
  ELSE V01.ausg_menge_einh_id
  END AS einh_kolli,
  CAST(V03_KOL.umrech_zaehler AS FLOAT64) / CAST(V03_KOL.umrech_nenner AS FLOAT64) AS faktor_kolli,
 V01.paletten_faktor_einh_id AS einh_pal,
  CAST(V02_PAL.umrech_zaehler AS FLOAT64) / CAST(V02_PAL.umrech_nenner AS FLOAT64) AS faktor_pal
FROM kfl_production_dbp_view.v_art_vorschlagswert_per_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS V02_PAL ON V01.art_id = V02_PAL.art_id AND V01.mandant_id
      = V02_PAL.mandant_id AND V01.paletten_faktor_einh_id = V02_PAL.altnv_menge_einh_id AND V02_PAL.dat_bis =
   PARSE_DATE('%F', '9999-12-31')
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS V03_KOL ON V01.art_id = V03_KOL.art_id AND V01.mandant_id
      = V03_KOL.mandant_id AND V01.ausg_menge_einh_id = V03_KOL.altnv_menge_einh_id AND V03_KOL.dat_bis = PARSE_DATE('%F'
    , '9999-12-31')
WHERE V01.dat_bis = PARSE_DATE('%F', '9999-12-31');