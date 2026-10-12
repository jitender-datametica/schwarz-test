
CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_lagerbew_det_1 (USERID STRING) AS
SELECT V01.art_id,
 V01.auto_fg,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
   CASE
   WHEN V03.wrg_typ_id = 0
   THEN V01.betrag_lagerbew * V02.umrechnungskurs * V04.ek_anzeige_fg
   ELSE V01.betrag_lagerbew * V04.ek_anzeige_fg
   END * CASE
   WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648',
      'Z11') AND V01.mandant_id <> 1
   THEN -1
   ELSE 1
   END AS betrag_lagerbew,
   CASE
   WHEN V03.wrg_typ_id = 0
   THEN V01.betrag_verkauf * V02.umrechnungskurs
   ELSE V01.betrag_verkauf
   END * CASE
   WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648',
      'Z11') AND V01.mandant_id <> 1
   THEN -1
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
  WHEN V01.lagerplatz_id IS NULL
  THEN 'Kein Lagerplatz'
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
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11'
     ) AND V01.mandant_id <> 1
  THEN V01.menge_lagerbew_kolli * -1
  ELSE V01.menge_lagerbew_kolli
  END AS menge_lagerbew_kolli,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11'
     ) AND V01.mandant_id <> 1
  THEN V01.menge_lagerbew_bme * -1
  ELSE V01.menge_lagerbew_bme
  END AS menge_lagerbew_bme,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11'
     ) AND V01.mandant_id <> 1
  THEN V01.menge_lief * -1
  ELSE V01.menge_lief
  END AS menge_lief,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11'
     ) AND V01.mandant_id <> 1
  THEN CAST(V01.menge_lieferschein AS NUMERIC)
  ELSE V01.menge_lieferschein
  END AS menge_lieferschein,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11'
     ) AND V01.mandant_id <> 1
  THEN V01.menge_lagerbew_palette * -1
  ELSE V01.menge_lagerbew_palette
  END AS menge_lagerbew_palette,
 V01.nb_id,
 V01.soll_haben_kz,
 V03.wrg_id,
 V01.wup_id,
 V01.dat_buch,
 CAST(ROUND(CAST(SUBSTR(V01.kunde_id, 7, 4) AS FLOAT64)) AS INTEGER) AS kunde_id,
  CASE
  WHEN V01.empfaenger_id IS NULL
  THEN 0
  ELSE COALESCE(V06.aktuell_wup_id, V01.empfaenger_id)
  END AS empfaenger_id,
 V01.gp_id,
 V03.wrg_typ_id,
   CASE
   WHEN V03.wrg_typ_id = 0
   THEN V01.betrag_vk_netto_vz * V02.umrechnungskurs
   ELSE V01.betrag_vk_netto_vz
   END * CASE
   WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648',
      'Z11') AND V01.mandant_id <> 1
   THEN -1
   ELSE 1
   END AS betrag_vk_netto_vz
FROM kfl_production_dbp_view.v_lagerbew_det_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V06 ON V06.mandant_id = CASE
     WHEN V01.mandant_id_empfaenger IS NULL OR V01.mandant_id_empfaenger = 0
     THEN V01.mandant_id
     ELSE V01.mandant_id_empfaenger
     END AND V01.empfaenger_id = V06.wup_id AND V06.nb_id = 0
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_kurs_1 AS V02 ON V01.wrg_id = V02.von_wrg_id AND V01.lagerort_id
   NOT IN ('-1', '-2', '-3')
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V05 ON V03.wrg_typ_id = V05.wrg_typ_id
  
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu_1 AS V04 ON TRUE;
