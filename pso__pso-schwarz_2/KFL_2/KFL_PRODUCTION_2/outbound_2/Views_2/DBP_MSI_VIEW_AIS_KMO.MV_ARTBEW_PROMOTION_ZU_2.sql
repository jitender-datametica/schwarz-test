-- Einschränkung auf promo_fg = 1, um Verdopplungen zu vermeiden; sschuecke 15.07.2016

-- AND v01.nb_id = v04.nb_id  entfernt, Fehlerkorrektur

-- INC0795721 Daten kommen bereits in Landeswährung, daher Änderung der Umrechnung auf wrg_typ_id = 0; sschuecke 06.07.2016

-- AND v01.wup_id = v04.wup_id
 -- 20160610 kkaiser: Zeilen unter -- Ermittlung EK netto2 und EK netto3:

-- Erweiterung CROSS JOIN auf artbew_2, um gp_id zu ermitteln; sschuecke 07.07.2016

-- Anfo #592827 Erweiterung Feld menge_promo, umsatz_promo_netto, umsatz_mwst; sschuecke 18.07.2014

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artbew_promotion_zu_2 (art_id, mandant_id, wup_id, nb_id,
dat, bonuskauf_id, konditionsart_id, ean_kasse, wrg_id, betrag_promo_netto, betrag_promo_netto_abgleich, betrag_mwst,
betrag_mwst_abgleich, umsatz_promo_netto, umsatz_mwst, menge_promo, ek_netto2_promo, ek_netto4_promo, umrechnungskurs)
AS -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025

/* CAST (CASE
   WHEN v03.dat IS NOT NULL THEN COALESCE(v01.betrag_promo_netto, 0)
   END AS NUMERIC(18,8)) AS betrag_promo_netto_abgleich, */
/* CAST (CASE
   WHEN v03.dat IS NOT NULL THEN COALESCE(v01.betrag_mwst, 0)
   END AS NUMERIC(18,8)) AS betrag_mwst_abgleich, */
/* JOIN KFL_PRODUCTION.dbp_view.v_kurs_2 v300
   ON CURRENT_DATE BETWEEN v300.dat_von AND v300.dat_bis
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR' */
-- CROSS JOIN aktueller Berichtskurs
 -- AP0227085/SPEC0284781 Filter E-Loading Artikel_2 / sschuecke 25.02.2025
 SELECT
 V01.art_id,
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat,
 COALESCE(V02.bonuskauf_id, '-1') AS bonuskauf_id,
 V01.konditionsart_id,
 V01.ean_kasse,
 V01.wrg_id,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_promo_netto, 0)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.betrag_promo_netto, 0) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.betrag_promo_netto, 0) * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS betrag_promo_netto,
 CAST(CASE
   WHEN V03.dat IS NOT NULL AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_promo_netto, 0)
   WHEN V03.dat IS NOT NULL AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.betrag_promo_netto, 0) * V300.umrechnungskurs
   WHEN V03.dat IS NOT NULL AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.betrag_promo_netto, 0) * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS betrag_promo_netto_abgleich,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_mwst, 0)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.betrag_mwst, 0) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.betrag_mwst, 0) * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS betrag_mwst,
 CAST(CASE
   WHEN V03.dat IS NOT NULL AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag_mwst, 0)
   WHEN V03.dat IS NOT NULL AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.betrag_mwst, 0) * V300.umrechnungskurs
   WHEN V03.dat IS NOT NULL AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.betrag_mwst, 0) * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS betrag_mwst_abgleich,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.umsatz_promo_netto, 0)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.umsatz_promo_netto, 0) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.umsatz_promo_netto, 0) * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS umsatz_promo_netto,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.umsatz_mwst, 0)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.umsatz_mwst, 0) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.umsatz_mwst, 0) * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS umsatz_mwst,
 V01.menge_promo,
 CAST(V05.ek_nettonetto * V01.menge_promo AS NUMERIC) AS ek_netto2_promo,
 CAST(V05.einstandspreis * V01.menge_promo AS NUMERIC) AS ek_netto4_promo,
 V01.umrechnungskurs
FROM kfl_production_dbp_data.artbew_promotion_zu_2 AS V01
 INNER JOIN kfl_production_dbp_data.mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id
 LEFT JOIN kfl_production_dbp_data.l_bonuskauf_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.bonuskauf_id = V02.bonuskauf_id
   
 LEFT JOIN kfl_production_dbp_msi_view_ais_kmo.mv_bonuskauf_mandant_kondition_2 AS V03 ON V01.mandant_id = V03.mandant_id
    AND V01.bonuskauf_id = V03.bonuskauf_id AND V01.dat = V03.dat AND V01.konditionsart_id = V03.konditionsart_id
 INNER JOIN kfl_production_dbp_data.artbew_2 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.wup_id = V04.wup_id AND V01
           .nb_id = V04.nb_id AND V01.art_id = V04.art_id AND V01.dat = V04.dat -- Ermittlung EK netto2 und EK netto3

       AND (V01.mandant_id <> 5 OR V01.art_id <> 206731500) AND (V01.mandant_id <> 2 OR V01.art_id <> 208124500) AND (V01
        .mandant_id <> 3 OR V01.art_id <> 208113690) AND (V01.mandant_id <> 6 OR V01.art_id <> 208131570) AND (V01.mandant_id
       NOT IN (4, 7) OR V01.art_id <> 208114740) AND (V01.mandant_id <> 8 OR V01.art_id <> 208131640)
 INNER JOIN kfl_production_dbp_data.art_gp_wup_zu_per_2 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.art_id = V05.art_id
       AND V01.wrg_id = V05.wrg_id AND V01.dat BETWEEN V05.dat_von AND V05.dat_bis AND V04.gp_id = V05.gp_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_data.kurs_2 AS V300 ON V100.default_wrg = V300.von_wrg_id
 INNER JOIN kfl_production_dbp_data.kurs_2 AS V400 ON V01.dat BETWEEN V400.dat_von AND V400.dat_bis AND V100.default_wrg =
   V400.von_wrg_id
WHERE V400.kurstyp_id = 3
 AND V400.nach_wrg_id = 'EUR'
 AND V300.dat_bis = DATE '9999-12-31'
 AND V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR' -- CROSS JOIN historischer Berichtskurs

 AND V01.mandant_id <> 1
 AND V04.promo_fg = 1 -- AP0190987/SPEC0225041 Filter E-Loading Artikel_2 / sschuecke 17.11.2023
;