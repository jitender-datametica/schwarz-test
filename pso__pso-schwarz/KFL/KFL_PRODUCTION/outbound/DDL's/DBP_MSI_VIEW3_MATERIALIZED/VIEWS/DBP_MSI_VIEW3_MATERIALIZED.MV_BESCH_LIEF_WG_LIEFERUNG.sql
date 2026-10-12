CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_besch_lief_wg_lieferung (wup_id, nb_id, art_id,
wg_id, owg_id, arthiertyp_id, lagernummer_id, mandant_id, dat_lief_soll, werbeware_id, bestellart_id, lief_typ_id,
lief_pal_typ_id, mandant_id_kunde, kunde_id, lief_beleg_id, lief_beleg_pos_id, kj, auslieferungsgruppe_id,
menge_lief_soll_kolli, menge_lief_ist_kolli) AS SELECT LIPS.wup_id,
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
 LIKP.mandant_id_kunde,
 W.aktuell_wup_id AS kunde_id,
 LIPS.lief_beleg_id,
 LIPS.lief_beleg_pos_id,
 LIPS.kj,
 COALESCE(ART_AUSL.auslieferungsgruppe_id, COALESCE(WG_AUSL.auslieferungsgruppe_id, '-1')) AS auslieferungsgruppe_id,
 LIPS.menge_lief_soll_kolli,
 LIPS.menge_lief_ist_kolli
FROM kfl_production_dbp_view.v_besch_lief_det AS LIPS
 INNER JOIN kfl_production_dbp_view.v_besch_lief AS LIKP ON LIPS.mandant_id = LIKP.mandant_id AND LIPS.lief_beleg_id =
    LIKP.lief_beleg_id AND LIPS.dat_lief_soll = LIKP.dat_lief_soll
 LEFT JOIN kfl_production_dbp_view.v_wup AS W ON W.mandant_id = CASE
     WHEN LIKP.mandant_id_kunde IS NULL OR LIKP.mandant_id_kunde = 0
     THEN LIKP.mandant_id
     ELSE LIKP.mandant_id_kunde
     END AND W.wup_id = CASE
     WHEN SAFE_CAST(ROUND(CAST(LIKP.kunde_id AS FLOAT64)) AS INTEGER) = 0
     THEN NULL
     ELSE SAFE_CAST(ROUND(CAST(LIKP.kunde_id AS FLOAT64)) AS INTEGER)
     END AND (W.nb_id IN (2, 0, -111) AND W.wup_id > 0 OR W.nb_id = -1 AND W.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per AS MARC ON LIKP.mandant_id_kunde = MARC.mandant_id AND LIPS.art_id
      = MARC.art_id AND SAFE_CAST(ROUND(CAST(LIKP.kunde_id AS FLOAT64)) AS INTEGER) = MARC.wup_id AND LIKP.dat_lief_soll
   BETWEEN MARC.dat_von AND MARC.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per AS MAW1 ON LIPS.mandant_id = MAW1.mandant_id AND LIPS.art_id
     = MAW1.art_id AND LIPS.dat_lief_soll BETWEEN MAW1.dat_von AND MAW1.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS AWG ON LIPS.mandant_id = AWG.mandant_id AND LIPS.art_id = AWG.art_id
      AND LIPS.dat_lief_soll BETWEEN AWG.dat_von AND AWG.dat_bis AND AWG.arthiertyp_id = 2
 LEFT JOIN kfl_production_dbp_view.v_art_auslieferungsgruppe_per AS ART_AUSL ON LIPS.mandant_id = ART_AUSL.mandant_id
   AND LIPS.art_id = ART_AUSL.art_id AND LIPS.dat_lief_soll BETWEEN ART_AUSL.dat_von AND ART_AUSL.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wg_auslieferungsgruppe_per AS WG_AUSL ON LIPS.mandant_id = WG_AUSL.mandant_id AND
     AWG.wg_id = WG_AUSL.wg_id AND CASE
     WHEN WG_AUSL.sortimentslistenart_id = ''
     THEN ''
     ELSE MAW1.sortimentslistenart_id
     END = WG_AUSL.sortimentslistenart_id AND LIPS.dat_lief_soll BETWEEN WG_AUSL.dat_von AND WG_AUSL.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wg_per AS WG ON AWG.wg_id = WG.wg_id AND AWG.mandant_id = WG.mandant_id AND LIKP.dat_lief_soll
   BETWEEN WG.dat_von AND WG.dat_bis;