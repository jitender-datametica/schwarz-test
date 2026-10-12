CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_in_art_keine_bewegung (mandant_id, in_art_id, kjmo,
menge_bestand_bme, betrag_preis_bestand) AS SELECT t8.mandant_id,
 t8.in_art_id,
 t8.kjmo,
 bewkreis.menge_bestand_bme,
 bewkreis.betrag_preis_bestand
FROM (SELECT A.mandant_id,
    A.in_art_id,
    B.kjmo
   FROM kfl_production_dbp_view.v_in_art_per AS A
    INNER JOIN kfl_production_dbp_view.v_monat AS B ON B.max_dat BETWEEN A.dat_von AND A.dat_bis
    INNER JOIN kfl_production_dbp_view.v_in_art AS E ON A.mandant_id = E.mandant_id AND A.in_art_id = E.in_art_id
   WHERE (E.artikelart_id IN ('ZSAK', 'ZSDI', 'ZSKO', 'ZSWG') OR E.in_art_nr LIKE 'W%' OR E.in_art_id = - 1)
    AND A.normalposition_fg = 1
    AND A.aktiv_fg = 1
   GROUP BY A.mandant_id,
    A.in_art_id,
    B.kjmo
   EXCEPT DISTINCT
   SELECT v1.mandant_id,
    v1.in_art_id,
    v0.kjmo
   FROM (SELECT A.kjmo,
      ROUND(CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(A.kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(A.kjmo as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(A.kjmo as STRING)), INTERVAL - 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(A.kjmo as STRING)),
           INTERVAL - 1 MONTH))) AS BIGNUMERIC), 0) AS kjmo_vm,
      B.max_dat AS dat_periode_ende,
      DATE_SUB(B.max_dat, INTERVAL 59 DAY) AS dat_periode_beginn
     FROM kfl_production_dbp_view.v_monat AS A
      INNER JOIN kfl_production_dbp_view.v_monat AS B ON ROUND(CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(A.kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(A.kjmo as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(A.kjmo as STRING)), INTERVAL - 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m'
             , SAFE_CAST(A.kjmo as STRING)), INTERVAL - 1 MONTH))) AS BIGNUMERIC), 0) = B.kjmo) AS v0
    INNER JOIN (SELECT V1.mandant_id,
      V1.in_art_id,
      V0.dat_buch
     FROM kfl_production_dbp_view.v_in_lagerbew AS V0
      INNER JOIN kfl_production_dbp_view.v_in_lagerbew_det AS V1 ON V0.mandant_id = V1.mandant_id AND V0.kj = V1.kj AND
        V0.lagerbew_beleg_id = V1.lagerbew_beleg_id
      INNER JOIN kfl_production_dbp_view.v_in_werk AS V2 ON V1.mandant_id = V2.mandant_id AND V1.werk_id = V2.werk_id
     WHERE V1.in_bewart_id IN ('645', '647', '101')
      AND V1.lagerbew_beleg_storno_id IS NULL
      AND V2.werk_nr IN ('DE01', 'PL02', 'CZ02', 'SK02', 'HR02', 'RO02', 'BG02')) AS v1 ON v1.dat_buch BETWEEN v0.dat_periode_beginn
     AND v0.dat_periode_ende
   GROUP BY v0.kjmo,
    v1.mandant_id,
    v1.in_art_id) AS t8
 LEFT JOIN (SELECT v0.mandant_id,
   v0.in_art_id,
   ROUND(CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(V10.kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(V10.kjmo as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(V10.kjmo as STRING)), INTERVAL 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(V10.kjmo as STRING)),
        INTERVAL 1 MONTH))) AS BIGNUMERIC), 0) AS kjmo,
   SUM(v0.menge_bestand_bme) AS menge_bestand_bme,
   SUM(v0.betrag_preis_bestand) AS betrag_preis_bestand
  FROM (SELECT V00.mandant_id,
     V00.in_art_id,
     V00.dat,
     V00.menge_bestand_bme,
      CASE
      WHEN V04.wrg_typ_id = 0
      THEN CAST(V00.betrag_preis_bestand AS BIGNUMERIC) * V05.umrechnungskurs
      ELSE CAST(V00.betrag_preis_bestand AS BIGNUMERIC)
      END AS betrag_preis_bestand
    FROM kfl_production_dbp_view.v_in_art_bewertungskreis_tag AS V00
     INNER JOIN kfl_production_dbp_view.v_mandant AS V03 ON V00.mandant_id = V03.mandant_id
     INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V04 ON TRUE
     INNER JOIN kfl_production_dbp_view.v_kurs AS V05 ON V03.default_wrg = V05.von_wrg_id AND V00.dat BETWEEN V05.dat_von
         AND V05.dat_bis AND V05.kurstyp_id = 9 AND V05.nach_wrg_id = 'EUR') AS v0
   INNER JOIN kfl_production_dbp_view.v_monat AS V10 ON v0.dat = V10.max_dat
  GROUP BY v0.mandant_id,
   v0.in_art_id,
   kjmo) AS bewkreis ON t8.mandant_id = bewkreis.mandant_id AND t8.kjmo = bewkreis.kjmo AND t8.in_art_id = bewkreis.in_art_id;