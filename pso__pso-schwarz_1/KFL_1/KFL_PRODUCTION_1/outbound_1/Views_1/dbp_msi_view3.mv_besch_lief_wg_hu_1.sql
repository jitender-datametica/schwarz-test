-- 2022-05-17, AP0101988, SPEC0121842, adding art_id in CROSS JOIN to besch_lief_det_1, dknop

-- ,TRY_CAST(likp.kunde_id AS INTEGER ) AS kunde_id

-- 2022-05-20, AP0101988, SPEC0121842, dknop, adding hud.kj_lief_beleg=lips.kj

-- 2022-04-20, AP0101988, dknop, adding hu_status_id, arthiertyp_id, updating logic for menge_handling_kolli_hu

-- 2022-03-22, AP0101988, dknop, New way to determine Ausliefergruppe

-- 2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

-- 2022-04-19, AP0101988, dknop, changing logic for menge_handling_kolli_hu

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_besch_lief_wg_hu_1 (wup_id, nb_id, wg_id, arthiertyp_id, owg_id,
lagernummer_id, mandant_id, dat_lief_soll, bestellart_id, lief_typ_id, lief_pal_typ_id, mandant_id_kunde, kunde_id,
auslieferungsgruppe_id, handling_unit_id_ext, handling_unit_id, hu_status_id, menge_handling_kolli_hu) AS SELECT LIPS.wup_id
 ,
 LIPS.nb_id,
 WG.wg_id,
 WG.arthiertyp_id,
 WG.owg_id,
 LIKP.lagernummer_id,
 LIKP.mandant_id,
 LIKP.dat_lief_soll,
 LIPS.bestellart_id,
 LIKP.lief_typ_id,
 LIKP.lief_pal_typ_id,
 LIKP.mandant_id_kunde,
  CASE
  WHEN ROUND(SAFE_CAST(LIKP.kunde_id AS BIGNUMERIC), 0) = 0
  THEN NULL
  ELSE W.aktuell_wup_id
  END AS kunde_id_,
 COALESCE(ART_AUSL.auslieferungsgruppe_id, COALESCE(WG_AUSL.auslieferungsgruppe_id, '-1')) AS auslieferungsgruppe_id,
 HU.handling_unit_id_ext,
 HU.handling_unit_id,
 HU.hu_status_id,
 SUM(CASE
   WHEN LIPS.besch_palette_fg = 1 AND A.artikelart_id <> '-1' AND A.artikelart_id <> 'Z983'
   THEN HUD.menge_handling_kolli / 50
   ELSE HUD.menge_handling_kolli
   END) AS menge_handling_kolli_hu
FROM kfl_production_dbp_view.v_handling_unit_det_1 AS HUD
 INNER JOIN kfl_production_dbp_view.v_besch_lief_det_1 AS LIPS ON HUD.mandant_id = LIPS.mandant_id AND HUD.wup_id = LIPS.wup_id
         AND HUD.lief_beleg_id = LIPS.lief_beleg_id AND HUD.lief_beleg_pos_id = LIPS.lief_beleg_pos_id AND HUD.art_id =
     LIPS.art_id AND HUD.kj_lief_beleg = LIPS.kj AND HUD.hu_typ_id = 1
 INNER JOIN kfl_production_dbp_view.v_handling_unit_1 AS HU ON HUD.lief_beleg_id = HU.lief_beleg_id AND HUD.handling_unit_id
      = HU.handling_unit_id AND HUD.mandant_id = HU.mandant_id AND HUD.wup_id = HU.wup_id
 INNER JOIN kfl_production_dbp_view.v_besch_lief_1 AS LIKP ON HU.lief_beleg_id = LIKP.lief_beleg_id AND HU.kj_lief_beleg =
   LIKP.kj
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS W ON W.mandant_id = CASE
     WHEN LIKP.mandant_id_kunde IS NULL OR LIKP.mandant_id_kunde = 0
     THEN LIKP.mandant_id
     ELSE LIKP.mandant_id_kunde
     END AND W.wup_id = CASE
     WHEN ROUND(SAFE_CAST(LIKP.kunde_id AS BIGNUMERIC), 0) = 0
     THEN NULL
     ELSE ROUND(SAFE_CAST(LIKP.kunde_id AS BIGNUMERIC), 0)
     END AND (W.nb_id IN (2, 0, - 111) AND W.wup_id > 0 OR W.nb_id = - 1 AND W.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS AWG ON LIPS.mandant_id = AWG.mandant_id AND LIPS.art_id = AWG.art_id
      AND LIPS.dat_lief_soll BETWEEN AWG.dat_von AND AWG.dat_bis AND AWG.arthiertyp_id = 2
 INNER JOIN kfl_production_dbp_view.v_wg_per_1 AS WG ON AWG.wg_id = WG.wg_id AND AWG.mandant_id = WG.mandant_id AND LIKP.dat_lief_soll
   BETWEEN WG.dat_von AND WG.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_1 AS A ON HUD.art_id = A.art_id AND HUD.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS MAW1_1 ON LIPS.mandant_id = MAW1.mandant_id AND LIPS.art_id
     = MAW1.art_id AND LIPS.dat_lief_soll BETWEEN MAW1.dat_von AND MAW1.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_auslieferungsgruppe_per_1 AS ART_AUSL ON LIPS.mandant_id = ART_AUSL.mandant_id
   AND LIPS.art_id = ART_AUSL.art_id AND LIPS.dat_lief_soll BETWEEN ART_AUSL.dat_von AND ART_AUSL.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wg_auslieferungsgruppe_per_1 AS WG_AUSL ON LIPS.mandant_id = WG_AUSL.mandant_id AND
     AWG.wg_id = WG_AUSL.wg_id AND CASE
     WHEN WG_AUSL.sortimentslistenart_id = ''
     THEN ''
     ELSE MAW1.sortimentslistenart_id
     END = WG_AUSL.sortimentslistenart_id AND LIPS.dat_lief_soll BETWEEN WG_AUSL.dat_von AND WG_AUSL.dat_bis
GROUP BY LIPS.wup_id,
 LIPS.nb_id,
 WG.wg_id,
 WG.arthiertyp_id,
 WG.owg_id,
 LIKP.lagernummer_id,
 LIKP.mandant_id,
 LIKP.dat_lief_soll,
 LIPS.bestellart_id,
 LIKP.lief_typ_id,
 LIKP.lief_pal_typ_id,
 LIKP.mandant_id_kunde,
 kunde_id_,
 auslieferungsgruppe_id,
 HU.handling_unit_id_ext,
 HU.handling_unit_id,
 HU.hu_status_id;
