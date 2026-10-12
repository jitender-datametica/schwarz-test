CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_besch_best_det_1 (art_id, best_beleg_id, best_beleg_pos_id,
best_preis_menge_einh_id, best_menge_einh_id, dat_aenderung, dat_best_beleg, endlief_fg, lagerort_id, loesch_fg,
mandant_id, menge_best_bme, menge_best_kolli, menge_best_palette, nb_id, selbstabhol_fg, wup_id, filiale_id, kunde_id,
bestellart_id, gp_id, lieferndeswerk, lieferndeswerk_nb_id, wrg_id, wrg_typ_id, menge_block_bestand, gp_teilsortiment_id
, betrag_best, umrechnungskurs) AS SELECT V01.art_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.best_preis_menge_einh_id,
 V01.best_menge_einh_id,
 V01.dat_aenderung,
 V01.dat_best_beleg,
 V01.endlief_fg,
 V01.lagerort_id,
 V01.loesch_fg,
 V01.mandant_id,
 V01.menge_best_bme,
 V01.menge_best_kolli,
 V01.menge_best_palette,
 V01.nb_id,
 V01.selbstabhol_fg,
  CASE
  WHEN V01.nb_id = - 111
  THEN V01.wup_id
  ELSE 0
  END AS wup_id,
  CASE
  WHEN SAFE_CAST(V01.wup_id AS BIGNUMERIC) = 0
  THEN NULL
  ELSE V05.aktuell_wup_id
  END AS filiale_id,
 ROUND(CAST(SUBSTR(V01.kunde_id, 7, 4) AS BIGNUMERIC), 0) AS kunde_id,
 V02.bestellart_id,
 V02.gp_id,
 V02.wup_id AS lieferndeswerk,
 V02.nb_id AS lieferndeswerk_nb_id,
 V04.wrg_id,
 V04.wrg_typ_id,
 V01.menge_block_bestand,
 V01.gp_teilsortiment_id,
 V01.betrag_best,
 V03.umrechnungskurs
FROM kfl_production_dbp_view.v_besch_best_det_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V05.wup_id = CASE
     WHEN SAFE_CAST(V01.wup_id AS BIGNUMERIC) = 0
     THEN NULL
     ELSE SAFE_CAST(V01.wup_id AS BIGNUMERIC)
     END AND (V05.nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_besch_best_1 AS V02 ON V01.best_beleg_id = V02.best_beleg_id AND V01.mandant_id =
    V02.mandant_id AND V01.dat_best_beleg = V02.dat_best_beleg
 INNER JOIN kfl_production_dbp_msi_view3.mv_kurs_1 AS V03 ON V01.wrg_id = V03.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V04 ON V01.mandant_id = V04.mandant_id
WHERE V02.einkaufsorganisation_id <> 5000
 AND V02.loesch_fg = 0
 AND V01.loesch_fg = 0
 AND EXTRACT(YEAR FROM V01.dat_best_beleg) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;