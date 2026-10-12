CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artbew_mo_ek_cp_sum_regalachse (kjmo, art_id, fbb_nr,
fachboden_nr, fachboden_pos, bewart_id, mandant_id, wup_id, nb_id, wrg_id, umsatz_netto, betrag_kmep,
preis_abschrift_netto) AS SELECT DISTINCT V01.kjmo,
 V01.art_id,
 V02.fbb_nr,
 V02.fachboden_nr,
 V02.fachboden_pos,
 V01.bewart_id,
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.wrg_id,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
  THEN V01.umsatz_netto * V02.kapazitaet_faktor
  WHEN V01.wrg_id = 'EUR' AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
  THEN V01.umsatz_netto * V01.umrechnungskurs_hist * V02.kapazitaet_faktor
  ELSE V01.umsatz_netto * V02.kapazitaet_faktor
  END AS umsatz_netto,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
  THEN V01.betrag_kmep * V02.kapazitaet_faktor
  WHEN V01.wrg_id = 'EUR' AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
  THEN V01.betrag_kmep * V01.umrechnungskurs_hist * V02.kapazitaet_faktor
  ELSE V01.betrag_kmep
  END AS betrag_kmep,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
  THEN V01.preis_abschrift_netto * V02.kapazitaet_faktor
  WHEN V01.wrg_id = 'EUR' AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
  THEN V01.preis_abschrift_netto * V01.umrechnungskurs_hist * V02.kapazitaet_faktor
  ELSE V01.preis_abschrift_netto
  END AS preis_abschrift_netto
FROM kfl_production_dbp_view.v_artbew_mo_ek_cp_sum AS V01
 INNER JOIN kfl_production_dbp_view.v_regalachse_akt AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
             AND V01.wup_id = V02.wup_id AND V01.nb_id = V02.nb_id AND (V01.mandant_id <> 5 OR V01.art_id <> 206731500)
       AND (V01.mandant_id <> 2 OR V01.art_id <> 20812450) AND (V01.mandant_id <> 3 OR V01.art_id <> 20811369) AND (V01
        .mandant_id <> 6 OR V01.art_id <> 20813157) AND (V01.mandant_id NOT IN (4, 7) OR V01.art_id <> 20811474) AND (V01
      .mandant_id <> 8 OR V01.art_id <> 20813164) AND (V01.umsatz_netto <> 0 OR V01.betrag_kmep IS NOT NULL OR V01.preis_abschrift_netto
      <> 0)
 INNER JOIN kfl_production_dbp_view.v_mandant AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V04 ON CASE
   WHEN V01.wrg_id = 'EUR'
   THEN 0
   ELSE 1
   END = CASE
   WHEN V03.default_wrg = 'EUR'
   THEN 0
   ELSE V04.wrg_typ_id
   END
WHERE V01.mandant_id > 1
 AND V01.wup_bereinigt_fg = 0;