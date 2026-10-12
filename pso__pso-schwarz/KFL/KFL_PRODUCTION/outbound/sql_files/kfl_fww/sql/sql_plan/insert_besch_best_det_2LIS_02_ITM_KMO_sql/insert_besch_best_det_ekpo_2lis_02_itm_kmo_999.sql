UPDATE dbp_etl.kmo_ekpo_2lis_02_itm SET
 gp_id = ag.gp_id FROM (SELECT mandant_id,
   art_id,
   dat_von,
   dat_bis,
   gp_id
  FROM dbp_data.art_gp_zu_per) AS ag
WHERE kmo_ekpo_2lis_02_itm.art_id = ag.art_id AND kmo_ekpo_2lis_02_itm.mandant_id = ag.mandant_id AND
  kmo_ekpo_2lis_02_itm.dat_best_beleg BETWEEN ag.dat_von AND ag.dat_bis;


DROP TABLE IF EXISTS dbp_etl.art_wup_man_sp_besch_best_tmp;


CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_man_sp_besch_best_tmp (
mandant_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
faktor_ek_effektivpreis NUMERIC(29,4)
);


-- Hier die betriebsspezifischen manuellen Spannenfaktoren
 INSERT INTO dbp_etl.art_wup_man_sp_besch_best_tmp
(mandant_id, art_id, wup_id, nb_id, faktor_ek_effektivpreis)
(SELECT mandant_id,
  art_id,
  wup_id,
  nb_id,
  ek_faktor
 FROM (SELECT mandant_id,
     art_id,
     wup_id,
     nb_id,
     ek_faktor
    FROM dbp_data.art_wup_man_spanne_per AS E
    WHERE konditionsart_id = 'ZWGE' /* ek_netto */
     AND loesch_fg = 0
     AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    UNION DISTINCT
    SELECT mandant_id,
     art_id,
     - 1 AS wup_id,
     - 1 AS nb_id,
     ek_faktor
    FROM dbp_data.art_man_spanne_per AS E
    WHERE konditionsart_id = 'ZWGE' /* ek_netto */
     AND loesch_fg = 0
     AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis) AS t3);


UPDATE dbp_etl.kmo_ekpo_2lis_02_itm SET
 ek_netto = a.ek_effektivpreis /* in KMO Einstandspreis verwenden */,
 gp_id = a.gp_id,
 wrg_id = a.wrg_id FROM (SELECT A.mandant_id,
   A.wup_id,
   A.nb_id,
   A.art_id,
   Z.gp_id,
   M.default_wrg AS wrg_id,
   COALESCE(COALESCE(MA.faktor_ek_effektivpreis, MS.faktor_ek_effektivpreis), COALESCE(E.ek_netto, EE.ek_netto), 0.0000
    ) AS ek_effektivpreis
  FROM dbp_etl.kmo_ekpo_2lis_02_itm AS A
   INNER JOIN dbp_data.mandant AS M ON A.mandant_id = M.mandant_id
    -- Lieferant und Ausstiegspunkt ermitteln

   LEFT JOIN dbp_data.art_gp_nm_zu_per AS Z ON A.mandant_id = Z.mandant_id AND A.wup_id = Z.wup_id AND A
      .art_id = Z.art_id AND CURRENT_DATE("Europe/Berlin") BETWEEN Z.dat_von AND Z.dat_bis -- Betriebsspezifischer EK Preis

   LEFT JOIN dbp_data.art_gp_wup_zu_per AS E ON Z.mandant_id = E.mandant_id AND Z.vz_wup_id = E.wup_id
        AND Z.art_id = E.art_id AND Z.gp_id = E.gp_id AND CURRENT_DATE("Europe/Berlin") BETWEEN E.dat_von AND E.dat_bis AND MOD(Z.bq_findung_id
       , 2) = 1 /* ungerade BQ Findung ID Zugriff mit Wup */ AND Z.bq_findung_id <> 25
     /* aber ohne Ausstiegspunkt "keine BQ Findung moeglich" */ -- Betriebsuebergreifender EK Preis

   LEFT JOIN dbp_data.art_gp_wup_zu_per AS EE ON Z.mandant_id = EE.mandant_id AND - 1 = EE.wup_id AND Z.art_id
         = EE.art_id AND Z.gp_id = EE.gp_id AND CURRENT_DATE("Europe/Berlin") BETWEEN EE.dat_von AND EE.dat_bis AND MOD(Z.bq_findung_id,
      2) = 0 /* gerade BQ Findung ID Zugriff ohne Wup */ -- Ermittlung betriebsuebergreifernde manuelle Spannenfaktoren

     
   LEFT JOIN dbp_etl.art_wup_man_sp_besch_best_tmp AS MS ON A.mandant_id = MS.mandant_id AND A.art_id =
       MS.art_id AND MS.wup_id = 0 AND Z.bq_findung_id = 27 -- Ermittlung Betriebsspezifischer manuelle Spannefaktoren

   LEFT JOIN dbp_etl.art_wup_man_sp_besch_best_tmp AS MA ON A.mandant_id = MA.mandant_id AND A.art_id =
       MA.art_id AND A.wup_id = MA.wup_id AND Z.bq_findung_id = 26
  WHERE A.mandant_id > 1
  GROUP BY A.mandant_id,
   A.wup_id,
   A.nb_id,
   A.art_id,
   Z.gp_id,
   wrg_id,
   ek_effektivpreis /* BQ Findung FBB uebergreifend */) AS a
WHERE kmo_ekpo_2lis_02_itm.mandant_id = a.mandant_id AND kmo_ekpo_2lis_02_itm.wup_id = a.wup_id AND kmo_ekpo_2lis_02_itm
   .nb_id = a.nb_id AND kmo_ekpo_2lis_02_itm.art_id = a.art_id;


DROP TABLE IF EXISTS dbp_etl.fww_kmo_perf_tmp1;


CREATE TABLE IF NOT EXISTS dbp_etl.fww_kmo_perf_tmp1 AS
SELECT dat_best_beleg_orig AS dat_best_beleg
FROM dbp_etl.kmo_ekpo_2lis_02_itm
WHERE dat_best_beleg_orig IS NOT NULL
GROUP BY dat_best_beleg;


DELETE FROM dbp_data.besch_best_det
WHERE dat_best_beleg IN (SELECT dat_best_beleg
    FROM dbp_etl.fww_kmo_perf_tmp1) AND mandant_id > 1 AND (mandant_id, best_beleg_id, best_beleg_pos_id
   , dat_best_beleg) IN (SELECT (mandant_id, best_beleg_id, best_beleg_pos_id, dat_best_beleg_orig)
   FROM dbp_etl.kmo_ekpo_2lis_02_itm
   WHERE dat_best_beleg_orig IS NOT NULL);


-- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen
 INSERT INTO dbp_data
.besch_best_det (mandant_id, best_beleg_id, best_beleg_pos_id, art_id, wup_id, nb_id, lagerort_id, loesch_fg,
 menge_best_bme, selbstabhol_fg, best_preis_menge_einh_id, menge_best_kolli, menge_best_palette, endlief_fg,
 dat_aenderung, kunde_id, dat_best_beleg, best_menge_einh_id, ean_id, betrag_kond_zw_sum2, pos_kostenlos_fg,
 betrag_pos_netto, betrag_pos_netto_best_wrg, wrg_id, betrag_best, menge_block_bestand, gp_teilsortiment_id, flw_fg,
 zentral_best_fg, anforderer_name, bedarfsnummer, td_insert, td_update)
(SELECT T.mandant_id,
  T.best_beleg_id,
  T.best_beleg_pos_id,
  T.art_id,
  T.wup_id,
  T.nb_id,
  T.lagerort_id,
  T.loesch_fg,
  COALESCE(ROUND(CAST(CAST(T.menge_best_kolli AS FLOAT64) / COALESCE(COALESCE(AUKOLLI.umrech_faktor, AUKOLLI_AKT.umrech_faktor), COALESCE(AUKOLLI_ALTERNATIV.umrech_faktor, AUKOLLI_ALTERNATIV_AKT.umrech_faktor), 1) AS NUMERIC)
    , 3), 0) AS menge_best_neu,
  T.selbstabhol_fg,
  T.best_preis_menge_einh_id,
  T.menge_best_kolli,
  COALESCE(ROUND(CAST(COALESCE(ROUND(CAST(CAST(T.menge_best_kolli AS FLOAT64) / COALESCE(COALESCE(AUKOLLI.umrech_faktor
            , AUKOLLI_AKT.umrech_faktor), COALESCE(AUKOLLI_ALTERNATIV.umrech_faktor, AUKOLLI_ALTERNATIV_AKT.umrech_faktor
            ), 1) AS NUMERIC), 3), 0) * COALESCE(AUPALETTE.umrech_faktor, AUPALETTE_Q.umrech_faktor, 0) AS NUMERIC), 3)
   , 0) AS menge_best_palette,
  T.endlief_fg,
  T.dat_aenderung,
  T.kunde_id,
  T.dat_best_beleg,
  T.best_basismenge_einh_id,
  T.ean_id,
  T.betrag_kond_zw_sum2,
  T.pos_kostenlos_fg,
  T.betrag_pos_netto,
   CASE
   WHEN CAST(T.betrag_pos_netto_best_wrg AS NUMERIC) = 0.0000
   THEN ROUND(CAST(COALESCE(ROUND(CAST(CAST(T.menge_best_kolli AS FLOAT64) / COALESCE(COALESCE(AUKOLLI.umrech_faktor,
            AUKOLLI_AKT.umrech_faktor), COALESCE(AUKOLLI_ALTERNATIV.umrech_faktor, AUKOLLI_ALTERNATIV_AKT.umrech_faktor
            ), 1) AS NUMERIC), 3), 0) * CAST(CAST(T.ek_netto AS NUMERIC) AS FLOAT64) AS NUMERIC), 2)
   ELSE T.betrag_pos_netto_best_wrg
   END AS betrag_pos_netto_best_wrg,
  T.wrg_id,
  T.betrag_best,
  T.menge_block_bestand,
  T.gp_teilsortiment_id,
   CASE
   WHEN WGFZ.wg_id IS NOT NULL
   THEN 1
   ELSE 0
   END AS flw_fg,
  T.zentral_best_fg,
  T.anforderer_name,
  COALESCE(T.bedarfsnummer, '0') AS bedarfsnummer,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM dbp_etl.kmo_ekpo_2lis_02_itm AS T
  LEFT JOIN dbp_data.art_wg_zu_per AS AWZP ON T.mandant_id = AWZP.mandant_id AND T.art_id = AWZP.art_id
    AND AWZP.arthiertyp_id = 2 AND AWZP.dat_bis = PARSE_DATE('%F', '9999-12-31')
  LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUKOLLI ON T.art_id = AUKOLLI.art_id AND T.best_basismenge_einh_id
       = AUKOLLI.altnv_menge_einh_id AND T.dat_best_beleg BETWEEN AUKOLLI.dat_von AND AUKOLLI.dat_bis AND T.mandant_id =
    AUKOLLI.mandant_id -- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen

  LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUKOLLI_AKT ON T.art_id = AUKOLLI_AKT.art_id AND T.best_basismenge_einh_id
       = AUKOLLI_AKT.altnv_menge_einh_id AND AUKOLLI_AKT.dat_bis = DATE '9999-12-31' AND T.mandant_id = AUKOLLI_AKT.mandant_id
    -- Palettenfaktor und Default Mengeneinheit holen

  LEFT JOIN dbp_data.art_vorschlagswert_per AS AV ON T.art_id = AV.art_id AND T.dat_best_beleg BETWEEN AV
     .dat_von AND AV.dat_bis AND T.mandant_id = AV.mandant_id -- Umrechnungsfaktor fuer Palettenfaktor holen

  LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUPALETTE ON T.art_id = AUPALETTE.art_id AND AV.paletten_faktor_einh_id
       = AUPALETTE.altnv_menge_einh_id AND T.dat_best_beleg BETWEEN AUPALETTE.dat_von AND AUPALETTE.dat_bis AND T.mandant_id
     = AUPALETTE.mandant_id
    -- Default Umrechnungsfaktor fuer Basismenge holen, wenn Umrechnungsfaktor aus Bestellung NULL ist

  LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUKOLLI_ALTERNATIV ON T.art_id = AUKOLLI_ALTERNATIV.art_id
       AND AV.ausg_menge_einh_id = AUKOLLI_ALTERNATIV.altnv_menge_einh_id AND T.dat_best_beleg BETWEEN
     AUKOLLI_ALTERNATIV.dat_von AND AUKOLLI_ALTERNATIV.dat_bis AND T.mandant_id = AUKOLLI_ALTERNATIV.mandant_id -- 

  LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUKOLLI_ALTERNATIV_AKT ON T.art_id =
      AUKOLLI_ALTERNATIV_AKT.art_id AND AV.ausg_menge_einh_id = AUKOLLI_ALTERNATIV_AKT.altnv_menge_einh_id AND
     AUKOLLI_ALTERNATIV_AKT.dat_bis = DATE '9999-12-31' AND T.mandant_id = AUKOLLI_ALTERNATIV_AKT.mandant_id
    -- 80991231 Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen

  LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUKOLLI_Q ON T.art_id = AUKOLLI_Q.art_id AND T.best_basismenge_einh_id
       = AUKOLLI_Q.altnv_menge_einh_id AND AUKOLLI_Q.dat_bis = PARSE_DATE('%F', '9999-12-31') AND T.mandant_id =
    AUKOLLI_Q.mandant_id -- 80991231 Palettenfaktor und Default Mengeneinheit holen

  LEFT JOIN dbp_data.art_vorschlagswert_per AS AV_Q ON T.art_id = AV_Q.art_id AND T.dat_best_beleg
     BETWEEN AV_Q.dat_von AND AV_Q.dat_bis AND T.mandant_id = AV_Q.mandant_id
    -- 80991231 Umrechnungsfaktor fuer Palettenfaktor holen

  LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUPALETTE_Q ON T.art_id = AUPALETTE_Q.art_id AND
      AUPALETTE_Q.altnv_menge_einh_id = 'PAL' AND AUPALETTE_Q.dat_bis = PARSE_DATE('%F', '9999-12-31') AND T.mandant_id
    = AUPALETTE_Q.mandant_id
    -- 80991231 Default Umrechnungsfaktor fuer Basismenge holen, wenn Umrechnungsfaktor aus Bestellung NULL ist

  LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUKOLLI_ALTERNATIV_Q ON T.art_id = AUKOLLI_ALTERNATIV_Q
      .art_id AND AV_Q.ausg_menge_einh_id = AUKOLLI_ALTERNATIV_Q.altnv_menge_einh_id AND AUKOLLI_ALTERNATIV_Q.dat_bis =
     PARSE_DATE('%F', '9999-12-31') AND T.mandant_id = AUKOLLI_ALTERNATIV_Q.mandant_id
  LEFT JOIN dbp_data.wg_filter_zu AS WGFZ ON AWZP.wg_id = WGFZ.wg_id AND AWZP.mandant_id = WGFZ.mandant_id
       AND WGFZ.wg_filter_id = 23 AND WGFZ.arthiertyp_id = 2
 WHERE T.dat_best_beleg_orig IS NOT NULL);


UPDATE dbp_data.besch_best_det SET
 zentral_best_fg = 1 FROM (SELECT DISTINCT T1.mandant_id,
   T1.best_beleg_id,
   T1.best_beleg_pos_id,
   T1.art_id,
   T1.wup_id,
   T1.dat_best_beleg
  FROM dbp_data.besch_best_det AS T1
   INNER JOIN dbp_etl.kmo_ekpo_2lis_02_itm AS X ON T1.mandant_id = X.mandant_id AND T1.best_beleg_id = X
         .best_beleg_id AND T1.best_beleg_pos_id = X.best_beleg_pos_id AND T1.wup_id = X.wup_id AND T1.dat_best_beleg =
      X.dat_best_beleg AND T1.art_id = X.art_id
   LEFT JOIN dbp_data.fur_best_vor AS T2 ON T1.mandant_id = T2.mandant_id AND T1.wup_id = T2.wup_id AND
      T1.art_id = T2.art_id AND T1.dat_best_beleg = T2.dat_dispo
  WHERE T1.anforderer_name = 'ZFRE0150_INT') AS b
WHERE besch_best_det.mandant_id = b.mandant_id AND besch_best_det.best_beleg_id = b.best_beleg_id AND besch_best_det.best_beleg_pos_id
      = b.best_beleg_pos_id AND besch_best_det.art_id = b.art_id AND besch_best_det.wup_id = b.wup_id AND besch_best_det
  .dat_best_beleg = b.dat_best_beleg;


UPDATE dbp_data.besch_best SET
 empfaenger_wup_id = bzeile.empfaenger_wup_id,
 anz_pos_aktiv = bzeile.anz_pos_aktiv,
 anz_pos_offen = bzeile.anz_pos_offen FROM (SELECT mandant_id,
   best_beleg_id,
   MAX(wup_id) AS empfaenger_wup_id,
   COUNT(*) AS anz_pos_aktiv,
   SUM(CASE
     WHEN endlief_fg = 1
     THEN 0
     ELSE 1
     END) AS anz_pos_offen
  FROM dbp_data.besch_best_det
  WHERE loesch_fg = 0
   AND (mandant_id, best_beleg_id, dat_best_beleg) IN (SELECT (mandant_id, best_beleg_id, dat_best_beleg)
     FROM dbp_etl.kmo_ekpo_2lis_02_itm
     WHERE IF(kopf_wup_id = 0, NULL, kopf_wup_id) IS NULL)
  GROUP BY mandant_id,
   best_beleg_id) AS bzeile
WHERE besch_best.mandant_id = bzeile.mandant_id AND besch_best.best_beleg_id = bzeile.best_beleg_id;


DROP TABLE IF EXISTS dbp_etl.lief_eint_tmp;


CREATE TABLE IF NOT EXISTS dbp_etl.lief_eint_tmp (
mandant_id INTEGER NOT NULL,
best_beleg_id INTEGER NOT NULL,
best_beleg_pos_id INTEGER NOT NULL,
einteil_id INTEGER NOT NULL,
menge_einteil NUMERIC(29,3) NOT NULL,
dat_lief_wunsch DATE NOT NULL,
dat_lief_bewertung DATE,
mahnung_anz INTEGER NOT NULL,
system_id INTEGER NOT NULL,
flw_fg INTEGER NOT NULL
);


INSERT INTO dbp_etl.lief_eint_tmp (mandant_id, best_beleg_id, best_beleg_pos_id, einteil_id,
 menge_einteil, dat_lief_wunsch, dat_lief_bewertung, mahnung_anz, system_id, flw_fg)
(SELECT T3.mandant_id,
  T3.best_beleg_id,
  T3.best_beleg_pos_id,
  T3.einteil_id,
  T3.menge_einteil,
  T3.dat_lief_wunsch,
  T3.dat_lief_bewertung,
  T3.mahnung_anz,
  T3.system_id,
  T1.flw_fg
 FROM dbp_data.besch_best_det AS T1
  INNER JOIN dbp_etl.kmo_ekpo_2lis_02_itm AS T2 ON T1.mandant_id = T2.mandant_id AND T1.best_beleg_id =
      T2.best_beleg_id AND T1.best_beleg_pos_id = T2.best_beleg_pos_id AND T1.dat_best_beleg = T2.dat_best_beleg
  INNER JOIN dbp_data.lief_einteilung AS T3 ON T1.mandant_id = T3.mandant_id AND T1.best_beleg_id = T3.best_beleg_id
      AND T1.best_beleg_pos_id = T3.best_beleg_pos_id
 WHERE T1.flw_fg = 1
  AND T1.mandant_id = 2);


DELETE FROM dbp_data.lief_einteilung
WHERE (mandant_id, best_beleg_id, best_beleg_pos_id, dat_lief_wunsch) IN (SELECT (mandant_id, best_beleg_id,
    best_beleg_pos_id, dat_lief_wunsch)
  FROM dbp_etl.lief_eint_tmp);


INSERT INTO dbp_data.lief_einteilung (mandant_id, best_beleg_id, best_beleg_pos_id, einteil_id,
 menge_einteil, dat_lief_wunsch, dat_lief_bewertung, mahnung_anz, system_id, flw_fg)
(SELECT mandant_id,
  best_beleg_id,
  best_beleg_pos_id,
  einteil_id,
  menge_einteil,
  dat_lief_wunsch,
  dat_lief_bewertung,
  mahnung_anz,
  system_id,
  flw_fg
 FROM dbp_etl.lief_eint_tmp
 WHERE (mandant_id, best_beleg_id, best_beleg_pos_id, dat_lief_wunsch) NOT IN (SELECT (mandant_id, best_beleg_id,
      best_beleg_pos_id, dat_lief_wunsch)
    FROM dbp_data.lief_einteilung));