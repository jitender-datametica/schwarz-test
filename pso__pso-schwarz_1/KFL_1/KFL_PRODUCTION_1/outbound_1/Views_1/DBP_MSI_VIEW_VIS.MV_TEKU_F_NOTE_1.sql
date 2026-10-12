CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_teku_f_note_1 AS SELECT TB.teku_bericht_id,
 TB.dat_besuchs_beginn,
 TB.zeit_besuchs_beginn,
 TB.dat_besuchs_ende,
 TB.zeit_besuchs_ende,
 TB.dat_erfasst AS dat_aenderung,
 TB.mandant_id,
 TB.wup_id,
 TB.testkunde_id,
 TB.teku_checkliste_id,
 TFC.teku_frage_id,
 TC.frische_fg,
 TA.teku_antwort_id,
 CAST(TA.teku_antwort_note AS NUMERIC) AS detail_note,
 TA.teku_antwort_bez,
 LTK.teku_kategorie_nr,
 TFK.teku_frage_gewicht,
  TFK.teku_frage_gewicht * CAST(TA.teku_antwort_note AS NUMERIC) AS detail_note_gew
FROM kfl_production_dbp_view.v_teku_bericht_per_1 AS TB
 INNER JOIN kfl_production_dbp_view.v_l_teku_checkliste_1 AS TC ON TB.teku_checkliste_id = TC.teku_checkliste_id
 INNER JOIN kfl_production_dbp_view.v_teku_bericht_det_per_1 AS TA ON TB.teku_bericht_id = TA.teku_bericht_id AND (CASE
      WHEN TB.dat_bis = DATE '9999-12-31'
      THEN TB.dat_bis
      ELSE DATE_ADD(TB.dat_bis, INTERVAL 1 DAY)
      END >= TA.dat_von OR CASE
      WHEN TA.dat_bis = DATE '9999-12-31'
      THEN TA.dat_bis
      ELSE DATE_ADD(TA.dat_bis, INTERVAL 1 DAY)
      END >= TB.dat_von)
 INNER JOIN kfl_production_dbp_view.v_teku_frage_checkliste_zu_1 AS TFC ON TA.teku_fragestellung_id = TFC.teku_fragestellung_id
  
 INNER JOIN kfl_production_dbp_view.v_teku_frage_kategorie_zu_per_1 AS TFK ON TFC.teku_frage_id = TFK.teku_frage_id AND TB
   .dat_besuchs_beginn BETWEEN TFK.dat_von AND TFK.dat_bis
 INNER JOIN kfl_production_dbp_view.v_l_teku_kategorie_1 AS LTK ON TFK.teku_kategorie_id = LTK.teku_kategorie_id
WHERE TB.dat_bis = DATE '9999-12-31'
 AND (TA.teku_antwort_note > 0 OR TFK.teku_kategorie_id = 309)
 AND TB.loeschung_fg = 0
 AND TB.nicht_auswerten_fg = 0;