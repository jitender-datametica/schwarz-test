CREATE OR REPLACE TABLE dbp_etl.art_gp_wup_zu_per_kmo_tmp_1 (
mandant_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
gp_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER,
einkaufsorganisation_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE,
ek_brutto NUMERIC(29,4),
ek_netto NUMERIC(29,4),
ek_nettonetto NUMERIC(29,4),
ek_kal_basis NUMERIC(29,4),
ek_mep NUMERIC(29,4),
einstandspreis NUMERIC(29,4),
logistikkostenzuschlag NUMERIC(29,4),
bezugsweg_id INTEGER NOT NULL,
wrg_id STRING(3),
komponentenmenge NUMERIC(29,4),
ek_brutto_nrfb_rab NUMERIC(29,4),
bonusbasis NUMERIC(29,4),
bezugsnebenkosten NUMERIC(29,4),
zollwert NUMERIC(29,4),
ek_netto_bnk NUMERIC(29,4),
ek_netto_bnk_sachk NUMERIC(29,4),
ek_mep_vor_fwu NUMERIC(29,4),
cycle_id INTEGER,
ek_brutto_normal NUMERIC(29,4)
);


DELETE FROM dbp_etl.kmo_zekp_1
WHERE abrut = 0;


INSERT INTO dbp_etl.art_gp_wup_zu_per_kmo_tmp_1 (mandant_id, art_id, gp_id, wup_id, nb_id,
 einkaufsorganisation_id, dat_von, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
 logistikkostenzuschlag, bezugsweg_id, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis, bezugsnebenkosten,
 zollwert, ek_netto_bnk, ek_netto_bnk_sachk, ek_mep_vor_fwu, cycle_id, ek_brutto_normal)
(SELECT L.mandant_id,
  a.art_id_ AS art_id_,
  G.gp_id,
   CASE
   WHEN L.werks = 0
   THEN - 1
   ELSE W.wup_id
   END AS wup_id,
   CASE
   WHEN L.werks = 0
   THEN NULL
   ELSE W.nb_id
   END AS nb_id,
  G.einkaufsorganisation_id,
  L.datab AS dat_von,
  L.datbis AS dat_bis,
  L.abrut AS ek_brutto,
  L.aknet AS ek_netto,
  L.aknne AS ek_nettonetto,
  L.ekkba AS ek_kal_basis,
  L.mepre AS ek_mep,
  L.lsein AS einstandspreis,
  CAST(COALESCE(CASE
     WHEN W.nb_id <> - 111 OR L.abrut = 0 AND L.aknet = 0 AND L.aknne = 0 AND L.ekkba = 0 AND L.mepre = 0 AND L.lsein = 0
     THEN 0
     ELSE L.lokau
     END, 0) AS NUMERIC) AS logistikkostenzuschlag,
  0 AS bezugsweg_id,
  COALESCE(COLLATE(L.wrg_1, ''), COLLATE(M.default_wrg, '')) AS wrg_id,
  1 AS komponentenmenge,
  L.abrna AS ek_brutto_nrfb_rab,
  L.abonba AS bonusbasis,
  L.bnk AS bezugsnebenkosten,
  L.zollba AS zollwert,
  L.aknb AS ek_netto_bnk,
  L.aknbs AS ek_netto_bnk_sachk,
  L.mepol AS ek_mep_vor_fwu,
  L.cycle_id,
  L.ebrut AS ek_brutto_normal
 FROM dbp_etl.kmo_zekp_1 AS L
  INNER JOIN (SELECT mandant_id,
    kl_art_id,
    MAX(art_id) AS art_id_
   FROM dbp_data.art_1
   GROUP BY mandant_id,
    kl_art_id) AS a ON L.mandant_id = a.mandant_id AND L.matnr = a.kl_art_id
  INNER JOIN dbp_data.gp_1 AS G ON L.mandant_id = G.mandant_id AND L.lifnr = G.gp_id
  INNER JOIN dbp_data.mandant_1 AS M ON L.mandant_id = M.mandant_id
  LEFT JOIN dbp_data.wup_1 AS W ON L.mandant_id = W.mandant_id AND L.werks = W.wup_id);


INSERT INTO dbp_etl.art_gp_wup_zu_per_kmo_tmp_1 (mandant_id, art_id, gp_id, wup_id, nb_id,
 einkaufsorganisation_id, dat_von, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
 logistikkostenzuschlag, bezugsweg_id, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis, bezugsnebenkosten,
 zollwert, ek_netto_bnk, ek_netto_bnk_sachk, ek_mep_vor_fwu, cycle_id, ek_brutto_normal)
(SELECT A.mandant_id,
  A.art_id,
  A.gp_id,
  A.wup_id,
  A.nb_id,
  A.einkaufsorganisation_id,
  A.dat_von,
  A.dat_bis,
  A.ek_brutto,
  A.ek_netto,
  A.ek_nettonetto,
  A.ek_kal_basis,
  A.ek_mep,
  A.einstandspreis,
  A.logistikkostenzuschlag,
  A.bezugsweg_id,
  A.wrg_id,
  A.komponentenmenge,
  A.ek_brutto_nrfb_rab,
  A.bonusbasis,
  A.bezugsnebenkosten,
  A.zollwert,
  A.ek_netto_bnk,
  A.ek_netto_bnk_sachk,
  A.ek_mep_vor_fwu,
  A.cycle_id,
  A.ek_brutto_normal
 FROM dbp_data.art_gp_wup_zu_per_1 AS A
  INNER JOIN (SELECT mandant_id,
    art_id,
    gp_id,
    wup_id,
    bezugsweg_id,
    MIN(dat_von) AS dat_von_
   FROM dbp_etl.art_gp_wup_zu_per_kmo_tmp_1
   GROUP BY mandant_id,
    art_id,
    gp_id,
    wup_id,
    bezugsweg_id) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.gp_id = b.gp_id AND A.wup_id = b.wup_id
        AND A.bezugsweg_id = b.bezugsweg_id AND A.dat_bis >= b.dat_von_ AND A.dat_von < b.dat_von_);


UPDATE dbp_etl.art_gp_wup_zu_per_kmo_tmp_1 SET
 dat_bis = dt1.dat_bis_ FROM (SELECT mandant_id,
   wup_id,
   nb_id,
   art_id,
   dat_von,
   gp_id,
   bezugsweg_id,
    CASE
    WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY mandant_id, wup_id, nb_id
          , art_id, gp_id, bezugsweg_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) -
      ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) = 0
    THEN PARSE_DATE('%F', '9999-12-31')
    ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1
          PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)),
     INTERVAL - 1 DAY)
    END AS dat_bis_
  FROM (SELECT mandant_id,
     wup_id,
     nb_id,
     art_id,
     dat_von,
     gp_id,
     bezugsweg_id
    FROM dbp_etl.art_gp_wup_zu_per_kmo_tmp_1 AS L
    GROUP BY mandant_id,
     art_id,
     gp_id,
     wup_id,
     nb_id,
     dat_von,
     bezugsweg_id) AS t0
  QUALIFY dat_von <= CASE
     WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY mandant_id, wup_id,
           nb_id, art_id, gp_id, bezugsweg_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
         )) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) = 0
     THEN PARSE_DATE('%F', '9999-12-31')
     ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
             mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1
           PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)),
      INTERVAL - 1 DAY)
     END) AS dt1
WHERE art_gp_wup_zu_per_kmo_tmp.mandant_id = dt1.mandant_id AND art_gp_wup_zu_per_kmo_tmp.wup_id = dt1.wup_id AND
      art_gp_wup_zu_per_kmo_tmp.art_id = dt1.art_id AND art_gp_wup_zu_per_kmo_tmp.dat_von = dt1.dat_von AND
    art_gp_wup_zu_per_kmo_tmp.gp_id = dt1.gp_id AND art_gp_wup_zu_per_kmo_tmp.bezugsweg_id = dt1.bezugsweg_id AND
  art_gp_wup_zu_per_kmo_tmp.dat_bis <> dt1.dat_bis_;


DELETE FROM dbp_data.art_gp_wup_zu_per_1
WHERE (mandant_id, art_id, gp_id, wup_id, dat_von, bezugsweg_id) IN (SELECT (A.mandant_id, A.art_id, A.gp_id, A.wup_id,
    A.dat_von, A.bezugsweg_id)
  FROM dbp_data.art_gp_wup_zu_per_1 AS A
   INNER JOIN (SELECT mandant_id,
     art_id,
     gp_id,
     wup_id,
     bezugsweg_id,
     MIN(dat_von) AS dat_von_
    FROM dbp_etl.art_gp_wup_zu_per_kmo_tmp_1
    GROUP BY mandant_id,
     art_id,
     gp_id,
     wup_id,
     bezugsweg_id) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.gp_id = b.gp_id AND A.wup_id = b.wup_id
        AND A.bezugsweg_id = b.bezugsweg_id AND A.dat_von >= b.dat_von_);


INSERT INTO dbp_data.art_gp_wup_zu_per_1 (mandant_id, gp_id, wup_id, dat_von, bezugsweg_id, art_id, nb_id,
 einkaufsorganisation_id, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, ek_mep_vor_fwu,
 einstandspreis, logistikkostenzuschlag, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis, bezugsnebenkosten,
 zollwert, ek_netto_bnk, ek_netto_bnk_sachk, cycle_id, ek_brutto_normal, td_update, td_insert)
(SELECT mandant_id,
  gp_id,
  wup_id,
  dat_von,
  bezugsweg_id,
  art_id,
  nb_id,
  einkaufsorganisation_id,
  dat_bis,
  ek_brutto,
  ek_netto,
  ek_nettonetto,
  ek_kal_basis,
  ek_mep,
  ek_mep_vor_fwu,
  einstandspreis,
  logistikkostenzuschlag,
  wrg_id,
  komponentenmenge,
  ek_brutto_nrfb_rab,
  bonusbasis,
  bezugsnebenkosten,
  zollwert,
  ek_netto_bnk,
  ek_netto_bnk_sachk,
  cycle_id,
  ek_brutto_normal,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM dbp_etl.art_gp_wup_zu_per_kmo_tmp_1);


/**************** SPEC0243147 - Hrvoje **********/


DELETE FROM dbp_msi_data.art_gp_wup_rueckbewertung_mo_1
WHERE dat_abzug = CURRENT_DATE("Europe/Berlin");


-- 202407 fuer Test_1

/* ogas0311: Berechnung des 2-ten Arbeitstages in Monat_1, Feiertage und Sonntage sind ausgeschloessen */ -- 2 fuer Test_1

INSERT INTO dbp_msi_data.art_gp_wup_rueckbewertung_mo_1 (mandant_id, kjmo, art_id, gp_id, wup_id, nb_id,
 dat_gueltig_von, dat_gueltig_bis, dat_abzug, wrg_id, preis_ek_mep, preis_ek_mep_vor_fwu, preis_ek_netto_bnk,
 preis_ek_einstandspreis, preis_ek_nettonetto, preis_kmep_einh_o_fwu, td_update, td_insert)
WITH ARBEITSTAG_BERECHNUNG AS (SELECT EXTRACT(YEAR FROM dat) * 100 + EXTRACT(MONTH FROM dat) AS jahr_monat,
     CASE
     WHEN MIN(CASE
         WHEN EXTRACT(DAY FROM dat) = 1
         THEN erste
         ELSE 1
         END) + MIN(CASE
         WHEN EXTRACT(DAY FROM dat) = 2
         THEN zweite
         ELSE 1
         END) = 2
     THEN 2
     WHEN MIN(CASE
          WHEN EXTRACT(DAY FROM dat) = 1
          THEN erste
          ELSE 1
          END) + MIN(CASE
          WHEN EXTRACT(DAY FROM dat) = 2
          THEN zweite
          ELSE 1
          END) + MIN(CASE
         WHEN EXTRACT(DAY FROM dat) = 3
         THEN dritte
         ELSE 1
         END) = 2
     THEN 3
     WHEN MIN(CASE
           WHEN EXTRACT(DAY FROM dat) = 1
           THEN erste
           ELSE 1
           END) + MIN(CASE
           WHEN EXTRACT(DAY FROM dat) = 2
           THEN zweite
           ELSE 1
           END) + MIN(CASE
          WHEN EXTRACT(DAY FROM dat) = 3
          THEN dritte
          ELSE 1
          END) + MIN(CASE
         WHEN EXTRACT(DAY FROM dat) = 4
         THEN vierte
         ELSE 1
         END) = 2
     THEN 4
     WHEN MIN(CASE
            WHEN EXTRACT(DAY FROM dat) = 1
            THEN erste
            ELSE 1
            END) + MIN(CASE
            WHEN EXTRACT(DAY FROM dat) = 2
            THEN zweite
            ELSE 1
            END) + MIN(CASE
           WHEN EXTRACT(DAY FROM dat) = 3
           THEN dritte
           ELSE 1
           END) + MIN(CASE
          WHEN EXTRACT(DAY FROM dat) = 4
          THEN vierte
          ELSE 1
          END) + MIN(CASE
         WHEN EXTRACT(DAY FROM dat) = 5
         THEN fuenfte
         ELSE 1
         END) = 2
     THEN 5
     ELSE NULL
     END AS tag_ausfuerung
   FROM (SELECT tag.dat,
       CASE
       WHEN COALESCE(EXTRACT(DAY FROM a.dat), - 1) = 1 OR tag.wtag_id = 7
       THEN 0
       ELSE 1
       END AS erste,
       CASE
       WHEN COALESCE(EXTRACT(DAY FROM a.dat), - 1) = 2 OR tag.wtag_id = 7
       THEN 0
       ELSE 1
       END AS zweite,
       CASE
       WHEN COALESCE(EXTRACT(DAY FROM a.dat), - 1) = 3 OR tag.wtag_id = 7
       THEN 0
       ELSE 1
       END AS dritte,
       CASE
       WHEN COALESCE(EXTRACT(DAY FROM a.dat), - 1) = 4 OR tag.wtag_id = 7
       THEN 0
       ELSE 1
       END AS vierte,
       CASE
       WHEN COALESCE(EXTRACT(DAY FROM a.dat), - 1) = 5 OR tag.wtag_id = 7
       THEN 0
       ELSE 1
       END AS fuenfte
     FROM dbp_data.tag_1
      LEFT JOIN (SELECT T1.land_id,
        T3.dat,
        SUM(CASE
          WHEN T4.offen = 0
          THEN 1
          ELSE 0
          END) AS geschlossen
       FROM dbp_data.wup_1 AS T1_1
        LEFT JOIN dbp_data.region_1 AS T2 ON T1.region_id = T2.region_id AND T1.mandant_id = T2.mandant_id
         AND T1.land_id = T2.land_id
        INNER JOIN dbp_data.tag_1 AS T3 ON T3.dat BETWEEN T1.dat_von AND T1.dat_bis
        LEFT JOIN dbp_data.wupcal_ereignis_zu_1 AS T4 ON T1.wup_id = T4.wup_id AND T1.nb_id = T4.nb_id AND
            T1.mandant_id = T4.mandant_id AND T3.dat = T4.dat AND T4.ereignistyp_id <> 2
       WHERE T1.nb_id = 0
        AND T1.land_id = 'DE'
       GROUP BY T1.land_id,
        T3.dat) AS a ON tag.dat = a.dat AND a.geschlossen > 300
     WHERE EXTRACT(DAY FROM tag.dat) BETWEEN 1 AND 5) AS b
   WHERE EXTRACT(YEAR FROM dat) * 100 + EXTRACT(MONTH FROM dat) = EXTRACT(YEAR FROM CURRENT_DATE("Europe/Berlin")) * 100 + EXTRACT(MONTH
       FROM CURRENT_DATE("Europe/Berlin"))
   GROUP BY jahr_monat) (SELECT DISTINCT ART.mandant_id,
    CAST(ROUND(CAST(FORMAT_DATE('%Y%m', IF(CURRENT_DATE("Europe/Berlin") = LAST_DAY(CURRENT_DATE("Europe/Berlin")), LAST_DAY(DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL - 1 MONTH))) AS BIGNUMERIC), 0) AS INTEGER)
    AS kjmo,
    ART.art_id,
    ART.gp_id,
    ART.wup_id,
    COALESCE(ART.nb_id, - 199) AS nb_id,
    UMS.dat_von AS dat_gueltig_von,
    UMS.dat_bis AS dat_gueltig_bis,
    CURRENT_DATE("Europe/Berlin") AS dat_abzug,
    ART.wrg_id,
    ART.ek_mep AS preis_ek_mep,
    ART.ek_mep_vor_fwu AS preis_ek_mep_vor_fwu,
    ART.ek_netto_bnk AS preis_ek_netto_bnk,
    ART.einstandspreis AS preis_ek_einstandspreis,
    ART.ek_nettonetto AS preis_ek_nettonetto,
    UMS.betrag_kmep_einh_o_fwu AS preis_kmep_einh_o_fwu,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
   FROM dbp_data.art_gp_wup_zu_per_1 AS ART_1
    INNER JOIN ARBEITSTAG_BERECHNUNG AS t13 ON TRUE
    LEFT JOIN dbp_data.art_umsatz_kmep_zu_per_1 AS UMS ON ART.mandant_id = UMS.mandant_id AND ART.art_id =
      UMS.art_id
   WHERE CURRENT_DATE("Europe/Berlin") BETWEEN ART.dat_von AND ART.dat_bis
    AND UMS.zeitraum_kz = 'KM' -- AND CURRENT_DATE("Europe/Berlin") between ums.dat_von and ums.dat_bis

    AND ROUND(CAST(FORMAT_DATE('%Y%m', UMS.dat_von) AS BIGNUMERIC), 0) >= ROUND(CAST(FORMAT_DATE('%Y%m', IF(CURRENT_DATE("Europe/Berlin") = LAST_DAY(CURRENT_DATE("Europe/Berlin")), LAST_DAY(DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL - 1 MONTH))) AS BIGNUMERIC)
      , 0)
    AND ROUND(CAST(FORMAT_DATE('%Y%m', UMS.dat_bis) AS BIGNUMERIC), 0) <= ROUND(CAST(FORMAT_DATE('%Y%m', IF(CURRENT_DATE("Europe/Berlin") = LAST_DAY(CURRENT_DATE("Europe/Berlin")), LAST_DAY(DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL - 1 MONTH))) AS BIGNUMERIC)
      , 0)
    AND t13.jahr_monat = EXTRACT(YEAR FROM CURRENT_DATE("Europe/Berlin")) * 100 + EXTRACT(MONTH FROM CURRENT_DATE("Europe/Berlin"))
    AND t13.tag_ausfuerung = EXTRACT(DAY FROM CURRENT_DATE("Europe/Berlin")));