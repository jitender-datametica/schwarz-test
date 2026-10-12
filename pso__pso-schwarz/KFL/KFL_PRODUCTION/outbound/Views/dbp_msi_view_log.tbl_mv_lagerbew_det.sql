CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.tbl_mv_lagerbew_det (art_id, auto_fg, best_beleg_id,
best_beleg_pos_id, betrag_verkauf, einkaufsorganisation_id, erf_menge_einh_id, grund_id, kj, lager_bewart_id,
lagerbew_beleg_id, lagerbew_beleg_pos_id, lagerort_id, lagerplatz_id, mandant_id, mandant_id_empfaenger,
mandant_id_kunde, menge_lagerbew_kolli, menge_lagerbew_bme, menge_lief, menge_lieferschein, menge_lagerbew_palette,
nb_id, soll_haben_kz, wrg_id, wup_id, dat_buch, kunde_id, empfaenger_id, gp_id, wrg_typ_id, betrag_vk_netto_vz,
betrag_lagerbew, umrechnungskurs) AS SELECT V01.art_id,
 V01.auto_fg,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
   CASE
   WHEN V03.wrg_typ_id = 0
   THEN V01.betrag_verkauf * v02.umrechnungskurs
   ELSE V01.betrag_verkauf
   END * CASE
   WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND V01.mandant_id <> 1
   THEN - 1
   ELSE 1
   END AS betrag_verkauf,
 V01.einkaufsorganisation_id,
 V01.erfsngs_menge_einh_id AS erf_menge_einh_id,
 V01.grund_id,
 V01.kj,
 V01.lager_bewart_id,
 V01.lagerbew_beleg_id,
 V01.lagerbew_beleg_pos_id,
 V01.lagerort_id,
  CASE
  WHEN V01.lagerplatz_id IS NULL OR TRIM(V01.lagerplatz_id) = ''
  THEN 'NoStorGrnd'
  ELSE V01.lagerplatz_id
  END AS lagerplatz_id,
 V01.mandant_id,
  CASE
  WHEN V01.mandant_id_empfaenger IS NULL OR V01.mandant_id_empfaenger = 0
  THEN V01.mandant_id
  ELSE V01.mandant_id_empfaenger
  END AS mandant_id_empfaenger,
  CASE
  WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
  THEN V01.mandant_id
  ELSE V01.mandant_id_kunde
  END AS mandant_id_kunde,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND V01.mandant_id <> 1
  THEN V01.menge_lagerbew_kolli * - 1
  ELSE V01.menge_lagerbew_kolli
  END AS menge_lagerbew_kolli,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND V01.mandant_id <> 1
  THEN V01.menge_lagerbew_bme * - 1
  ELSE V01.menge_lagerbew_bme
  END AS menge_lagerbew_bme,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND V01.mandant_id <> 1
  THEN V01.menge_lief * - 1
  ELSE V01.menge_lief
  END AS menge_lief,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND V01.mandant_id <> 1
  THEN CAST(V01.menge_lieferschein AS NUMERIC)
  ELSE V01.menge_lieferschein
  END AS menge_lieferschein,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND V01.mandant_id <> 1
  THEN V01.menge_lagerbew_palette * - 1
  ELSE V01.menge_lagerbew_palette
  END AS menge_lagerbew_palette,
 V01.nb_id,
 V01.soll_haben_kz,
 V03.wrg_id,
 V01.wup_id,
 V01.dat_buch,
 ROUND(CAST(SUBSTR(V01.kunde_id, 7, 4) AS BIGNUMERIC), 0) AS kunde_id,
  CASE
  WHEN V01.empfaenger_id IS NULL
  THEN 0
  ELSE V01.empfaenger_id
  END AS empfaenger_id,
 V01.gp_id,
 V03.wrg_typ_id,
   CASE
   WHEN V03.wrg_typ_id = 0
   THEN V01.betrag_vk_netto_vz * v02.umrechnungskurs
   ELSE V01.betrag_vk_netto_vz
   END * CASE
   WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND V01.mandant_id <> 1
   THEN - 1
   ELSE 1
   END AS betrag_vk_netto_vz,
 V01.betrag_lagerbew,
 v02.umrechnungskurs
FROM kfl_production_dbp_view.v_lagerbew_det AS V01
 INNER JOIN (SELECT umrechnungskurs,
   von_wrg_id
  FROM kfl_production_dbp_view.v_kurs
  WHERE dat_bis = PARSE_DATE('%F', '9999-12-31')
   AND kurstyp_id = 3) AS v02 ON V01.wrg_id = v02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V03 ON V01.mandant_id = V03.mandant_id
WHERE V01.lagerort_id NOT IN ('-1', '-2', '-3');