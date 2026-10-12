-- 18.10.2021, AP0101988, SPEC0121842, dknop, left join and COLAESCE for auslieferungsgruppe_id

-- 2024-09-09, dknop, change to left join with dbp_view.v_wup_1

-- 26.10.2021,AP0101988, SPEC0121842, dknop, adding missing CROSS JOIN to dat_lief_soll for dbp_view.v_wg_per_1

-- 25.10.2021, AP0101988, SPEC0121842, dknop, removing duplicated rows from wup_kunde_wg_disporhythmus_lft_zu_per_1

-- 06.09.2021,  AP0101988, SPEC0121842, dknop, updating kunde_id
 -- 2024-01-31, INC7963291, dknop, change kunde_id

-- 04.08.2021, AP0101988, SPEC0121842, dknop, initial based on logic from nwagner

-- 22.10.2021, AP0101988, SPEC0121842, dknop, likp.mandant_id_kunde=marc.mandant_id

-- 2022-03-22, AP0101988, dknop, New way to determine Ausliefergruppe

-- 2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_besch_lief_wg_lieferung_1 (wup_id, nb_id, art_id, wg_id, owg_id,
arthiertyp_id, lagernummer_id, mandant_id, dat_lief_soll, werbeware_id, bestellart_id, lief_typ_id, lief_pal_typ_id,
mandant_id_kunde, kunde_id, lief_beleg_id, lief_beleg_pos_id, kj, auslieferungsgruppe_id, menge_lief_soll_kolli,
menge_lief_ist_kolli) AS SELECT LIPS.wup_id,
 LIPS.nb_id,
 MARC.art_id,
 WG.wg_id,
 WG.owg_id,
 WG.arthiertyp_id,
 LIKP.lagernummer_id,
 LIPS.mandant_id,
 LIKP.dat_lief_soll,
 LIKP.werbeware_id,
 LIPS.bestellart_id,
 LIKP.lief_typ_id,
 LIKP.lief_pal_typ_id,
 LIKP.mandant_id_kunde
 -- ,CASE WHEN TRY_CAST(likp.kunde_id AS INTEGER) IS NULL THEN -3 ELSE TRY_CAST(likp.kunde_id AS INTEGER) END AS kunde_id

 ,
 W.aktuell_wup_id AS kunde_id,
 LIPS.lief_beleg_id,
 LIPS.lief_beleg_pos_id,
 LIPS.kj,
 COALESCE(ART_AUSL.auslieferungsgruppe_id, COALESCE(WG_AUSL.auslieferungsgruppe_id, '-1')) AS auslieferungsgruppe_id,
 LIPS.menge_lief_soll_kolli,
 LIPS.menge_lief_ist_kolli
FROM kfl_production_dbp_view.v_besch_lief_det_1 AS LIPS
 INNER JOIN kfl_production_dbp_view.v_besch_lief_1 AS LIKP ON LIPS.mandant_id = LIKP.mandant_id AND LIPS.lief_beleg_id =
    LIKP.lief_beleg_id AND LIPS.dat_lief_soll = LIKP.dat_lief_soll
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W ON W.mandant_id = CASE
     WHEN LIKP.mandant_id_kunde IS NULL OR LIKP.mandant_id_kunde = 0
     THEN LIKP.mandant_id
     ELSE LIKP.mandant_id_kunde
     END AND W.wup_id = CASE
     WHEN ROUND(SAFE_CAST(LIKP.kunde_id AS BIGNUMERIC), 0) = 0
     THEN NULL
     ELSE ROUND(SAFE_CAST(LIKP.kunde_id AS BIGNUMERIC), 0)
     END AND (W.nb_id IN (2, 0, - 111) AND W.wup_id > 0 OR W.nb_id = - 1 AND W.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per_1 AS MARC_1 ON LIKP.mandant_id_kunde = MARC.mandant_id AND LIPS.art_id
      = MARC.art_id AND ROUND(SAFE_CAST(LIKP.kunde_id AS BIGNUMERIC), 0) = MARC.wup_id AND LIKP.dat_lief_soll BETWEEN
   MARC.dat_von AND MARC.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS MAW1_1 ON LIPS.mandant_id = MAW1.mandant_id AND LIPS.art_id
     = MAW1.art_id AND LIPS.dat_lief_soll BETWEEN MAW1.dat_von AND MAW1.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS AWG ON LIPS.mandant_id = AWG.mandant_id AND LIPS.art_id = AWG.art_id
      AND LIPS.dat_lief_soll BETWEEN AWG.dat_von AND AWG.dat_bis AND AWG.arthiertyp_id = 2
 LEFT JOIN kfl_production_dbp_view.v_art_auslieferungsgruppe_per_1 AS ART_AUSL ON LIPS.mandant_id = ART_AUSL.mandant_id
   AND LIPS.art_id = ART_AUSL.art_id AND LIPS.dat_lief_soll BETWEEN ART_AUSL.dat_von AND ART_AUSL.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wg_auslieferungsgruppe_per_1 AS WG_AUSL ON LIPS.mandant_id = WG_AUSL.mandant_id AND
     AWG.wg_id = WG_AUSL.wg_id AND CASE
     WHEN WG_AUSL.sortimentslistenart_id = ''
     THEN ''
     ELSE MAW1.sortimentslistenart_id
     END = WG_AUSL.sortimentslistenart_id AND LIPS.dat_lief_soll BETWEEN WG_AUSL.dat_von AND WG_AUSL.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wg_per_1 AS WG ON AWG.wg_id = WG.wg_id AND AWG.mandant_id = WG.mandant_id AND LIKP.dat_lief_soll
   BETWEEN WG.dat_von AND WG.dat_bis
   /* LEFT JOIN (SELECT  v01_1.mandant_id
    ,v01_1.wup_id
    ,v01_1.nb_id
    ,v01_1.mandant_id AS mandant_id_kunde
    ,v01_1.kunde_id
    ,v01_1.auslieferungsgruppe_id
    ,v01_1.terminierungsgruppe_1_id
    ,v01_1.terminierungsgruppe_2_id
    ,v01_1.terminierungsgruppe_3_id
    ,v01_1.disposition_rhythmus_ltf_id
    ,v01_1.wg_id
    ,v01_1.arthiertyp_id
    ,v01_1.dat_von
    ,v01_1.dat_bis
  FROM KFL_PRODUCTION.dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_1 v01_1
  QUALIFY ROW_NUMBER() OVER (PARTITION BY v01_1.mandant_id
         ,v01_1.wup_id
         ,v01_1.nb_id
         ,v01_1.kunde_id
         ,v01_1.wg_id
         ,v01_1.arthiertyp_id
         ,v01_1.terminierungsgruppe_1_id
         ,v01_1.terminierungsgruppe_2_id
         ,v01_1.terminierungsgruppe_3_id
         --,v01_1.dat_bis
      ORDER BY v01_1.sortimentslistenart_id DESC, v01_1.dat_bis DESC) = 1
      ) dispo
ON marc.mandant_id=dispo.mandant_id
AND TRY_CAST(likp.kunde_id AS INTEGER ) = dispo.kunde_id
AND lips.wup_id = dispo.wup_id
AND wg.wg_id = dispo.wg_id
AND marc.terminierungsgruppe_1_id=dispo.terminierungsgruppe_1_id
AND marc.terminierungsgruppe_2_id=dispo.terminierungsgruppe_2_id
AND marc.terminierungsgruppe_3_id=dispo.terminierungsgruppe_3_id
AND likp.dat_lief_soll BETWEEN dispo.dat_von AND dispo.dat_bis */
   -- where likp.dat_lief_soll='2022-03-11' and marc.art_id=104045900 and lips.wup_id=6906
;
