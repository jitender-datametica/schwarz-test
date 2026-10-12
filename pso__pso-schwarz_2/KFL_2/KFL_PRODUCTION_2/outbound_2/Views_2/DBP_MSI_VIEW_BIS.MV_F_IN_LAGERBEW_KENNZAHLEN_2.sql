CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_in_lagerbew_kennzahlen_2 (mandant_id, in_art_id, in_bewart_id
, dat_buch, menge_erf, menge, betrag_netto_wrg) AS SELECT V1.mandant_id,
 V1.in_art_id,
 V1.in_bewart_id,
 V0.dat_buch,
 V1.menge_erf,
 V1.menge,
  CASE
  WHEN V5.wrg_typ_id = 0
  THEN CAST(V3.betrag_pos_netto_best_wrg AS BIGNUMERIC) * V6.umrechnungskurs
  ELSE CAST(V3.betrag_pos_netto_best_wrg AS BIGNUMERIC)
  END AS betrag_netto_wrg
FROM kfl_production_dbp_view.v_in_lagerbew_2 AS V0
 INNER JOIN kfl_production_dbp_view.v_in_lagerbew_det_2 AS V1 ON V0.mandant_id = V1.mandant_id AND V0.kj = V1.kj AND V0.lagerbew_beleg_id
     = V1.lagerbew_beleg_id AND V1.lagerbew_beleg_storno_id IS NULL
 INNER JOIN kfl_production_dbp_view.v_in_werk_2 AS V2 ON V1.mandant_id = V2.mandant_id AND V1.werk_id = V2.werk_id
 INNER JOIN kfl_production_dbp_view.v_in_besch_best_det_2 AS V3 ON V1.mandant_id = V3.mandant_id AND V1.best_beleg_id = V3
    .best_beleg_id AND V1.best_beleg_pos_id = V3.best_beleg_pos_id
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V4 ON V1.mandant_id = V4.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V5 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V6 ON V4.default_wrg = V6.von_wrg_id AND V0.dat_buch BETWEEN V6.dat_von
   AND V6.dat_bis
 INNER JOIN kfl_production_dbp_view.v_in_art_2 AS E ON V1.mandant_id = E.mandant_id AND V1.in_art_id = E.in_art_id AND (E
      .artikelart_id IN ('ZSAK', 'ZSDI', 'ZSKO', 'ZSWG') OR SUBSTR(E.in_art_nr, 1, 1) = 'W' OR E.in_art_id = - 1)
WHERE V6.kurstyp_id = 9
 AND V6.nach_wrg_id = 'EUR'
 AND V1.in_bewart_id IN ('645', '647', '101')
 AND V2.werk_nr IN ('DE01', 'PL02', 'CZ02', 'SK02', 'HR02', 'RO02', 'BG02');