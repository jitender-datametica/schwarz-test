CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_umsatz_kmep_zu_per_kw_1 (mandant_id, art_id, dat,
wa_bonus) AS -- Wir rechnen nun mit der bereits vor-aggregierten Menge (sum_menge)

-- UNTERABFRAGE: Zusammenfassung Märkte pro Mandant_1, Artikel_1 und Tag_1, da sonst Vervielfältigungen

-- Berichtskursermittlung
 -- aktueller Berichtskurs

-- Filter E-Loading Artikel_1 (jetzt auf die aggregierten v01-Daten angewendet)
 SELECT v01.mandant_id,
 v01.art_id,
 v01.dat,
 SUM(v01.sum_menge * ROUND(CAST(CASE
      WHEN V200.wrg_typ_id = 0
      THEN V02.betrag_kmep_einh_o_fwu * V300.umrechnungskurs
      ELSE V02.betrag_kmep_einh_o_fwu
      END AS NUMERIC), 5)) AS wa_bonus
FROM (SELECT mandant_id,
   art_id,
   dat,
   SUM(menge) AS sum_menge
  FROM kfl_production_dbp_data.artbew_1
  WHERE mandant_id > 1 -- AND dat BETWEEN CURRENT_DATE() - 14 AND CURRENT_DATE() - 1

  GROUP BY mandant_id,
   art_id,
   dat) AS v01
 LEFT JOIN kfl_production_dbp_data.art_umsatz_kmep_zu_per_1 AS V02 ON v01.mandant_id = V02.mandant_id AND v01.dat BETWEEN
     V02.dat_von AND V02.dat_bis AND V02.zeitraum_kz = 'KW' AND v01.art_id = V02.art_id
 INNER JOIN kfl_production_dbp_data.mandant_1 AS V100 ON v01.mandant_id = V100.mandant_id AND (v01.mandant_id <> 5 OR v01
          .art_id <> 206731500) AND (v01.mandant_id <> 2 OR v01.art_id <> 208124500) AND (v01.mandant_id <> 3 OR v01.art_id
         <> 208113690) AND (v01.mandant_id <> 6 OR v01.art_id <> 208131570) AND (v01.mandant_id NOT IN (4, 7) OR v01.art_id
       <> 208114740) AND (v01.mandant_id <> 8 OR v01.art_id <> 208131640)
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_data.kurs_1 AS V300 ON V100.default_wrg = V300.von_wrg_id
WHERE V300.dat_bis = DATE '9999-12-31'
 AND V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR'
GROUP BY v01.mandant_id,
 v01.art_id,
 v01.dat;