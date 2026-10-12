-- 2022-08-04, richternic, AP0132142, SPEC0154921, change akt_msi_user_wrg_typ_zu_2 -> AKT_MSI_USER_PRJ_WRG_TYP_ZU

-- 16.12.2021, dknop, expanding condition with Z11
 -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2

-- 27.10.2021, dknop, Anpassung Moldau BEWART_2 643/644 based on LIS

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_lagerbew_lgort_grund_wup_2(USERID STRING) AS SELECT V01.mandant_id,
  CASE
  WHEN V01.mandant_id_empfaenger IS NULL OR V01.mandant_id_empfaenger = 0
  THEN V01.mandant_id
  ELSE V01.mandant_id_empfaenger
  END AS mandant_id_empfaenger,
 V01.lagerort_id,
 V01.grund_id,
 V01.wup_id,
 V01.nb_id,
 V01.auto_fg,
 V01.dat_buch,
 V01.vorgangsart_id,
 V01.lager_bewart_id,
 V01.wg_id,
 V01.arthiertyp_id,
  CASE
  WHEN V01.empfaenger_id IS NULL
  THEN 0
  ELSE V01.empfaenger_id
  END AS empfaenger_id,
   CASE
   WHEN V03.wrg_typ_id = 0
   THEN V01.betrag_lagerbew * v02.umrechnungskurs
   ELSE V01.betrag_lagerbew
   END * CASE
   WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648',
      'Z11') AND V01.mandant_id <> 1
   THEN - 1
   ELSE 1
   END AS betrag_lagerbew,
   CASE
   WHEN V03.wrg_typ_id = 0
   THEN V01.betrag_verkauf * v02.umrechnungskurs
   ELSE V01.betrag_verkauf
   END * CASE
   WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648',
      'Z11') AND V01.mandant_id <> 1
   THEN - 1
   ELSE 1
   END AS betrag_verkauf,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11'
     ) AND V01.mandant_id <> 1
  THEN V01.menge_lagerbew_bme * - 1
  ELSE V01.menge_lagerbew_bme
  END AS menge_lagerbew_bme,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11'
     ) AND V01.mandant_id <> 1
  THEN V01.menge_lief * - 1
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
  THEN V01.menge_lagerbew_kolli * - 1
  ELSE V01.menge_lagerbew_kolli
  END AS menge_lagerbew_kolli,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11'
     ) AND V01.mandant_id <> 1
  THEN V01.menge_lagerbew_palette * - 1
  ELSE V01.menge_lagerbew_palette
  END AS menge_lagerbew_palette,
  CASE
  WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11'
     ) AND V01.mandant_id <> 1
  THEN V01.menge_erf * - 1
  ELSE V01.menge_erf
  END AS menge_erf,
 V03.wrg_id,
 V03.wrg_typ_id,
   CASE
   WHEN V03.wrg_typ_id = 0
   THEN V01.betrag_vk_netto_vz * v02.umrechnungskurs
   ELSE V01.betrag_vk_netto_vz
   END * CASE
   WHEN V01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648',
      'Z11') AND V01.mandant_id <> 1
   THEN - 1
   ELSE 1
   END AS betrag_vk_netto_vz,
 V01.lief_pal_typ_id
FROM kfl_production_dbp_view.v_lagerbew_lgort_grund_wup_2 AS V01
 INNER JOIN (SELECT umrechnungskurs,
   von_wrg_id
  FROM kfl_production_dbp_view.v_kurs_2
  WHERE dat_bis = PARSE_DATE('%F', '9999-12-31')
   AND kurstyp_id = 3) AS v02 ON V01.wrg_id = v02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS V04 ON V03.wrg_typ_id = V04.wrg_typ_id
WHERE V01.lagerort_id NOT IN ('-1', '-2', '-3');