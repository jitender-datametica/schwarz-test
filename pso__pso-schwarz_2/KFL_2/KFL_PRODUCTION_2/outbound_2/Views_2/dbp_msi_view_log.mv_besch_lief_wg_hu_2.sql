CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_besch_lief_wg_hu_2 (mandant_id, handling_unit_id,
handling_unit_pos_id, lief_beleg_id, lief_beleg_pos_id, transportation_unit_id, kj_transportation_unit, belos_vorgang_id
, wup_id, nb_id, lagernummer_id, versandstelle_id, lagerort_id, lagersortiment_id, artikelsortiment_id, diff_id,
dat_lief_soll, lief_typ_id, vertr_beleg_typ_id, arthiertyp_id, kunde_id, art_id, wg_id, owg_id, wg_verkett_lief,
lief_pal_typ_id, lief_pal_typ_dwh_id, mandant_id_kunde, werbeware_id, bestellart_id, hu_status_id, hu_relevant_fg,
handling_unit_id_ext_parent, hu_in_beziehung_fg, vol_relevant_fg, handling_unit_id_ext, handling_unit_id_parent,
wg_verkett_fg, menge_lief_ist_kolli_hu, auslieferungsgruppe_id) AS SELECT AGG.mandant_id,
 AGG.handling_unit_id,
 HUD.handling_unit_pos_id,
 HUD.lief_beleg_id,
 HUD.lief_beleg_pos_id,
 AGG.transportation_unit_id,
 EXTRACT(YEAR FROM AGG.dat_tour) AS kj_transportation_unit,
 AGG.belos_vorgang_id,
 AGG.wup_id,
 AGG.nb_id,
 AGG.lagernummer_id,
 AGG.versandstelle_id,
 LIPS.lagerort_id,
 AGG.lagersortiment_id,
  CASE
  WHEN LEFT(RIGHT(AGG.versandstelle_id, 2), 1) = '5'
  THEN '1'
  WHEN LEFT(RIGHT(AGG.versandstelle_id, 2), 1) = '7'
  THEN '2'
  ELSE LEFT(RIGHT(AGG.versandstelle_id, 2), 1)
  END AS artikelsortiment_id,
 LIPS.diff_id,
 AGG.dat_lief_soll,
 AGG.lief_typ_id,
 AGG.vertr_beleg_typ_id,
 AGG.arthiertyp_id,
 W.aktuell_wup_id AS kunde_id,
 HUD.art_id,
 AWG.wg_id,
 WG.owg_id,
 AGG.wg_verkett_lief,
 AGG.lief_pal_typ_id,
 AGG.lief_pal_typ_dwh_id,
 AGG.mandant_id_kunde,
 AGG.werbeware_id,
 LIPS.bestellart_id,
 AGG.hu_status_id,
 AGG.hu_relevant_fg,
 AGG.handling_unit_id_ext_parent,
 AGG.hu_in_beziehung_fg,
 AGG.vol_relevant_fg,
 AGG.handling_unit_id_ext,
 AGG.handling_unit_id_parent,
 AGG.wg_verkett_fg,
  HUD.verp_menge_bme / CASE
   WHEN LIPS.menge_lief_ist_kolli > 0
   THEN LIPS.menge_lief_ist_lme / LIPS.menge_lief_ist_kolli
   ELSE 1
   END AS menge_lief_ist_kolli_hu,
 COALESCE(ART_AUSL.auslieferungsgruppe_id, COALESCE(WG_AUSL.auslieferungsgruppe_id, '-1')) AS auslieferungsgruppe_id
FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum_2 AS AGG
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS W ON W.mandant_id = CASE
     WHEN AGG.mandant_id_kunde IS NULL OR AGG.mandant_id_kunde = 0
     THEN AGG.mandant_id
     ELSE AGG.mandant_id_kunde
     END AND AGG.kunde_id = W.wup_id AND (W.nb_id IN (2, 0, - 111) AND W.wup_id > 0 OR W.nb_id = - 1 AND W.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_handling_unit_det_2 AS HUD ON AGG.mandant_id = HUD.mandant_id AND AGG.lief_beleg_id
     = HUD.lief_beleg_id AND AGG.handling_unit_id = HUD.handling_unit_id AND AGG.wup_id = HUD.wup_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS AWG ON HUD.mandant_id = AWG.mandant_id AND HUD.art_id = AWG.art_id
      AND AGG.dat_lief_soll BETWEEN AWG.dat_von AND AWG.dat_bis AND AWG.arthiertyp_id = 2
 INNER JOIN kfl_production_dbp_view.v_wg_per_2 AS WG ON AWG.wg_id = WG.wg_id AND AWG.mandant_id = WG.mandant_id AND AGG.dat_lief_soll
   BETWEEN WG.dat_von AND WG.dat_bis
 INNER JOIN kfl_production_dbp_view.v_besch_lief_det_2 AS LIPS ON HUD.mandant_id = LIPS.mandant_id AND HUD.wup_id = LIPS.wup_id
       AND HUD.lief_beleg_id = LIPS.lief_beleg_id AND HUD.lief_beleg_pos_id = LIPS.lief_beleg_pos_id AND HUD.kj_lief_beleg
    = LIPS.kj
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_2 AS MAW1_2 ON LIPS.mandant_id = MAW1.mandant_id AND LIPS.art_id
     = MAW1.art_id AND LIPS.dat_lief_soll BETWEEN MAW1.dat_von AND MAW1.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_auslieferungsgruppe_per_2 AS ART_AUSL ON LIPS.mandant_id = ART_AUSL.mandant_id
   AND LIPS.art_id = ART_AUSL.art_id AND LIPS.dat_lief_soll BETWEEN ART_AUSL.dat_von AND ART_AUSL.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wg_auslieferungsgruppe_per_2 AS WG_AUSL ON LIPS.mandant_id = WG_AUSL.mandant_id AND
     AWG.wg_id = WG_AUSL.wg_id AND CASE
     WHEN WG_AUSL.sortimentslistenart_id = ''
     THEN ''
     ELSE MAW1.sortimentslistenart_id
     END = WG_AUSL.sortimentslistenart_id AND LIPS.dat_lief_soll BETWEEN WG_AUSL.dat_von AND WG_AUSL.dat_bis;