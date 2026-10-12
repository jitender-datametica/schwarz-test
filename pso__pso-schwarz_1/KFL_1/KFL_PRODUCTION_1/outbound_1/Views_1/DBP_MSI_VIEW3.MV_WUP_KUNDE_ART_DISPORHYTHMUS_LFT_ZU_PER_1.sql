CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_wup_kunde_art_disporhythmus_lft_zu_per_1 (mandant_id, wup_id, nb_id
, mandant_id_kunde, kunde_id, auslieferungsgruppe_id, terminierungsgruppe_1_id, terminierungsgruppe_2_id,
terminierungsgruppe_3_id, disposition_rhythmus_ltf_id, wg_id, arthiertyp_id, ausg_menge_einh_id, paletten_faktor_einh_id
, art_id, disponent_id, wg_verkett_id, dat_lief_soll, lagernummer_id, lagerort_id, lief_pal_typ_id, bestellart_id,
menge_lief_ist_kolli) AS SELECT v05.mandant_id,
 v05.wup_id,
 v05.nb_id,
 v05.mandant_id AS mandant_id_kunde,
  CASE
  WHEN SAFE_CAST(v05.kunde_id AS BIGNUMERIC) = 0
  THEN NULL
  ELSE V06.aktuell_wup_id
  END AS kunde_id,
 SUBSTR(CAST(COALESCE(v01.auslieferungsgruppe_id, '-1') AS STRING), 1, 4) AS auslieferungsgruppe_id,
 SUBSTR(CAST(COALESCE(v01.terminierungsgruppe_1_id, '-1') AS STRING), 1, 3) AS terminierungsgruppe_1_id,
 SUBSTR(CAST(COALESCE(v01.terminierungsgruppe_2_id, '-1') AS STRING), 1, 2) AS terminierungsgruppe_2_id,
 SUBSTR(CAST(COALESCE(v01.terminierungsgruppe_3_id, '-1') AS STRING), 1, 2) AS terminierungsgruppe_3_id,
 SUBSTR(CAST(COALESCE(v01.disposition_rhythmus_ltf_id, '-1') AS STRING), 1, 3) AS disposition_rhythmus_ltf_id,
 V02.wg_id,
 V02.arthiertyp_id,
 V03.ausg_menge_einh_id,
 V03.paletten_faktor_einh_id,
 v05.art_id,
 V04.disponent_id,
 V04.wg_verkett_id,
 v05.dat_lief_soll,
 v05.lagernummer_id,
 v05.lagerort_id,
 SUBSTR(CAST(v05.lief_pal_typ_id AS STRING), 1, 2) AS lief_pal_typ_id,
 v05.bestellart_id,
 v05.menge_lief_ist_kolli
FROM (SELECT t0.mandant_id,
   t0.kunde_id,
   t0.nb_id_kunde,
   t0.kunde_id0 AS dat_lief_soll,
   t0.dat_lief_soll AS lagernummer_id,
   t0.lagernummer_id AS lagerort_id,
   t0.lagerort_id AS lief_pal_typ_id,
   t0.lief_pal_typ_id AS wup_id,
   t0.wup_id AS nb_id,
   t0.nb_id AS art_id,
   t0.art_id AS best_beleg_id,
   t0.best_beleg_id AS bestellart_id,
   t0.bestellart_id AS menge_lief_ist_kolli
  FROM (SELECT V051.mandant_id,
     V051.wup_id AS kunde_id,
     V051.nb_id AS nb_id_kunde,
     V051.kunde_id AS kunde_id0,
     V051.dat_lief_soll,
     V051.lagernummer_id,
     V052.lagerort_id,
     V051.lief_pal_typ_id,
     V052.wup_id,
     V052.nb_id,
     V052.art_id,
     V052.best_beleg_id,
     V052.bestellart_id,
     SUM(V052.menge_lief_ist_kolli) AS menge_lief_ist_kolli
    FROM kfl_production_dbp_view.v_besch_lief_1 AS V051
     INNER JOIN kfl_production_dbp_view.v_besch_lief_det_1 AS V052 ON V051.mandant_id = V052.mandant_id AND V051.lief_beleg_id
          = V052.lief_beleg_id AND V051.dat_lief_soll = V052.dat_lief_soll AND V051.kj = V052.kj
    GROUP BY V051.mandant_id,
     kunde_id,
     nb_id_kunde,
     kunde_id0,
     V051.dat_lief_soll,
     V051.lagernummer_id,
     V052.lagerort_id,
     V051.lief_pal_typ_id,
     V052.wup_id,
     V052.nb_id,
     V052.art_id,
     V052.best_beleg_id,
     V052.bestellart_id) AS t0) AS v05
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V02 ON v05.mandant_id = V02.mandant_id AND v05.art_id = V02.art_id
      AND V02.arthiertyp_id = 2 AND V02.dat_bis = PARSE_DATE('%F', '9999-12-31')
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS V03 ON v05.mandant_id = V03.mandant_id AND v05.art_id =
    V03.art_id AND CAST(v05.dat_lief_soll AS DATE) BETWEEN V03.dat_von AND V03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per_1 AS V04 ON v05.mandant_id = V04.mandant_id AND v05.kunde_id =
     V04.wup_id AND V02.art_id = V04.art_id AND CAST(v05.dat_lief_soll AS DATE) BETWEEN V04.dat_von AND V04.dat_bis
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   mandant_id AS mandant_id_kunde,
   kunde_id,
   auslieferungsgruppe_id,
   terminierungsgruppe_1_id,
   terminierungsgruppe_2_id,
   terminierungsgruppe_3_id,
   disposition_rhythmus_ltf_id,
   wg_id,
   arthiertyp_id,
   dat_von,
   dat_bis
  FROM kfl_production_dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_1 AS V01_1
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(nb_id AS STRING), CAST(kunde_id AS STRING)
        , CAST(wg_id AS STRING), CAST(arthiertyp_id AS STRING), terminierungsgruppe_1_id, terminierungsgruppe_2_id,
        terminierungsgruppe_3_id, dat_bis ORDER BY sortimentslistenart_id IS NULL, sortimentslistenart_id)) = 1) AS v01
 ON v05.mandant_id = v01.mandant_id AND CAST(v05.wup_id AS FLOAT64) = v01.wup_id AND v05.nb_id = v01.nb_id AND v05.kunde_id
          = v01.kunde_id AND V02.wg_id = v01.wg_id AND V02.arthiertyp_id = v01.arthiertyp_id AND CAST(v05.dat_lief_soll AS DATE)
      BETWEEN v01.dat_von AND v01.dat_bis AND V04.terminierungsgruppe_1_id = v01.terminierungsgruppe_1_id AND V04.terminierungsgruppe_2_id
     = v01.terminierungsgruppe_2_id AND V04.terminierungsgruppe_3_id = v01.terminierungsgruppe_3_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V06 ON v05.mandant_id = V06.mandant_id AND V06.wup_id = CASE
     WHEN SAFE_CAST(v05.kunde_id AS BIGNUMERIC) = 0
     THEN NULL
     ELSE SAFE_CAST(v05.kunde_id AS BIGNUMERIC)
     END AND (V06.nb_id IN (2, 0, - 111) AND V06.wup_id > 0 OR V06.nb_id = - 1 AND V06.wup_id = 0);