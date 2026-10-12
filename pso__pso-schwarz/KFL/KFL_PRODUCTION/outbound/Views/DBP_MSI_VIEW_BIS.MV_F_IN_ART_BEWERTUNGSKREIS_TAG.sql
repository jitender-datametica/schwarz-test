CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_in_art_bewertungskreis_tag (mandant_id, in_art_id,
bewertungskreis_id, dat, menge_bestand_bme, betrag_preis_bestand) AS SELECT V1.mandant_id,
 V1.in_art_id,
 V1.bewertungskreis_id,
 V1.dat,
 V1.menge_bestand_bme,
  CASE
  WHEN V3.wrg_typ_id = 0
  THEN CAST(V1.betrag_preis_bestand AS BIGNUMERIC) * V4.umrechnungskurs
  ELSE CAST(V1.betrag_preis_bestand AS BIGNUMERIC)
  END AS betrag_preis_bestand
FROM kfl_production_dbp_view.v_in_art_bewertungskreis_tag AS V1
 INNER JOIN kfl_production_dbp_view.v_mandant AS V2 ON V1.mandant_id = V2.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V3 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V4 ON V2.default_wrg = V4.von_wrg_id AND V1.dat BETWEEN V4.dat_von AND V4
   .dat_bis
 INNER JOIN kfl_production_dbp_view.v_in_art AS E ON V1.mandant_id = E.mandant_id AND V1.in_art_id = E.in_art_id AND (E
      .artikelart_id IN ('ZSAK', 'ZSDI', 'ZSKO', 'ZSWG') OR SUBSTR(E.in_art_nr, 1, 1) = 'W' OR E.in_art_id = - 1)
WHERE V4.kurstyp_id = 9
 AND V4.nach_wrg_id = 'EUR'
 AND V1.betrag_preis_bestand <> 0
UNION ALL
SELECT V1.mandant_id,
 V1.in_art_id,
 V1.bewertungskreis_id,
 V1.dat,
 V1.menge_bestand_bme,
 V1.betrag_preis_bestand
FROM kfl_production_dbp_view.v_in_art_bewertungskreis_tag AS V1
 INNER JOIN kfl_production_dbp_view.v_in_art AS E ON V1.mandant_id = E.mandant_id AND V1.in_art_id = E.in_art_id
WHERE (E.artikelart_id IN ('ZSAK', 'ZSDI', 'ZSKO', 'ZSWG') OR SUBSTR(E.in_art_nr, 1, 1) = 'W' OR E.in_art_id = - 1)
 AND V1.betrag_preis_bestand = 0;